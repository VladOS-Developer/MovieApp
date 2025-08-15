//
//  FavoritesView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {

}

class FavoritesView: UIViewController {

    var presenter: FavoritesPresenterProtocol!
    
    private lazy var sectionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.text = "Favorite Movies"
        return $0
    }(UILabel())
    
    private lazy var topBackButton: UIButton = {
        $0.frame = CGRect(x: 20, y: 80, width: 20, height: 20)
        $0.setBackgroundImage(.appArrow, for: .normal)
        return $0
    }(UIButton(primaryAction: backButtonAction))
    
    lazy var backButtonAction = UIAction { [weak self] _ in
        guard let self = self,
              let tabBarVC = self.tabBarController as? TabBarView else { return }
        tabBarVC.selectedIndex = 0
        tabBarVC.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topBackButton)
        view.addSubview(sectionLabel)

        setupConstraints()
//        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
//        if let tabBarVC = self.tabBarController as? TabBarView {
//            tabBarVC.setTabBarButtonsHidden(true)
            print("TabBar скрылся")
//        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}

extension FavoritesView: FavoritesViewProtocol {
  
}
