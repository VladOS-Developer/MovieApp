//
//  SettingsPageView.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
}

class SettingsPageView: UIViewController {
    
    var presenter: SettingsPresenterProtocol!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarWithBackButton(title: "Settings", backAction: #selector(didTapBack))
        presenter.viewDidLoad()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
    }
    
}

extension SettingsPageView: SettingsViewProtocol {
    
}
