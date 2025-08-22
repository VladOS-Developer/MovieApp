//
//  TrailerPlayerView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerPlayerViewProtocol: AnyObject {
    func setTitle(_ text: String)
}

class TrailerPlayerView: UIViewController {
    
    var presenter: TrailerPlayerPresenterProtocol!
    
    private lazy var topBackButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        $0.setBackgroundImage(.appArrow, for: .normal)
        return $0
    }(UIButton(primaryAction: backButtonAction))
    
    private lazy var backButtonAction = UIAction { [weak self] _ in
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
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            topBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
    
}
