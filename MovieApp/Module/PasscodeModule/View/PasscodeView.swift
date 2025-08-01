//
//  PasscodeView.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol PasscodeViewProtocol: AnyObject {
    func passcodeState(state: PasscodeState)
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
    
    private lazy var passcodeTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .appWhite
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(passcodeTitle)
        
        NSLayoutConstraint.activate([
            passcodeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            passcodeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passcodeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    
}

extension PasscodeView: PasscodeViewProtocol {
    
    func passcodeState(state: PasscodeState) {
        passcodeTitle.text = state.passcodeLabel
        passcodeTitle.textColor = state.labelColor
    }
    
}
