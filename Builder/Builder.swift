//
//  Builder.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol BuilderProtocol {
    
}

class Builder: BuilderProtocol {
    
    static func getPasscodeController() -> UIViewController {
        let view = PasscodeView()
        let presenter = PasscodePresenter(view: view)
        
        view.passcodePresenter = presenter
        return view
    }
}
