//
//  SettingsPageRouter.swift
//  MovieApp
//
//  Created by VladOS on 19.11.2025.
//

import UIKit

protocol SettingsPageRouterProtocol: AnyObject {
    func showPasscodeModule(isSetting: Bool)
}

final class SettingsPageRouter: SettingsPageRouterProtocol {
    weak var viewController: UIViewController?
    
    func showPasscodeModule(isSetting: Bool) {
        let passcodeVC = Builder.getPasscodeController(sceneDelegate: nil, isSetting: isSetting)
        viewController?.navigationController?.pushViewController(passcodeVC, animated: true)
    }
}
