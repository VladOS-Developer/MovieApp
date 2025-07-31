//
//  PasscodeView.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol PasscodeViewProtocol: AnyObject {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PasscodeView: PasscodeViewProtocol {
    
}
