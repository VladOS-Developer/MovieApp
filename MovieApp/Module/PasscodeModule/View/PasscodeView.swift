//
//  PasscodeView.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol PasscodeViewProtocol: AnyObject {
    func passcodeState(state: PasscodeState)
    func enterCode(code: [Int])
}

class PasscodeView: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    var passcodePresenter: PasscodePresenterProtocol!
    
    private let buttons: [ [Int] ] = [ [1,2,3],
                                       [4,5,6],
                                       [7,8,9],
                                         [0] ]
    
    private lazy var passcodeTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .appWhite
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var codeStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    private lazy var keyboardStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var deleteBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 35).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        $0.setBackgroundImage(.deleteBtnWhite, for: .normal)
        return $0
    }(UIButton(primaryAction: deleteCodeAction))
    
    lazy var deleteCodeAction = UIAction { [weak self] sender in
        guard let self = self,
              let sender = sender.sender as? UIButton else { return }
        self.passcodePresenter.removeLastItemInPasscode()
    }
    
    lazy var enterCodeAction = UIAction { [weak self] sender in
        guard let self = self,
              let sender = sender.sender as? UIButton else { return }
        self.passcodePresenter.enterPasscode(number: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(passcodeTitle)
        view.addSubview(codeStack)
        view.addSubview(keyboardStack)
        view.addSubview(deleteBtn)
        
        buttons.forEach{
            let buttonLine = setHorizontalNumbersStack(range: $0)
            keyboardStack.addArrangedSubview(buttonLine)
        }
        
        (11...14).forEach {
            let view = getCodeStack(tag: $0)
            codeStack.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            passcodeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            passcodeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passcodeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            codeStack.topAnchor.constraint(equalTo: passcodeTitle.bottomAnchor, constant: 50),
            codeStack.widthAnchor.constraint(equalToConstant: 190),
            codeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            keyboardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            
            deleteBtn.rightAnchor.constraint(equalTo: keyboardStack.rightAnchor, constant: -27),
            deleteBtn.bottomAnchor.constraint(equalTo: keyboardStack.bottomAnchor, constant: -18)
        ])
    }
    
}

extension PasscodeView {
    
    private func getHorizontalNumbersStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 50
        return stack
    }
    
    private func setHorizontalNumbersStack(range: [Int]) -> UIStackView {
        let stack = getHorizontalNumbersStack()
        range.forEach {
            let numberButton = UIButton(primaryAction: enterCodeAction)
            numberButton.tag = $0
            numberButton.setTitle("\($0)", for: .normal)
            numberButton.setTitleColor(.appWhite, for: .normal)
            numberButton.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight: .regular)
            numberButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            stack.addArrangedSubview(numberButton)
        }
        return stack
    }
    
    private func getCodeStack(tag: Int) -> UIView {
        let codeView = UIView()
        codeView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        codeView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        codeView.layer.cornerRadius = 10
        codeView.layer.borderWidth = 2
        codeView.layer.borderColor = UIColor.appWhite.cgColor
        codeView.tag = tag
        return codeView
    }
}

extension PasscodeView: PasscodeViewProtocol {
    
    func enterCode(code: [Int]) {
        (11...14).forEach { tag in
            let dot = view.viewWithTag(tag)
            dot?.backgroundColor = code.count >= tag - 10 ? .appWhite : .clear
        }
    }
    
    func passcodeState(state: PasscodeState) {
        passcodeTitle.text = state.passcodeLabel
        passcodeTitle.textColor = state.labelColor
    }
    
}
