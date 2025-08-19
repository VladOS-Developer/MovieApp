//
//  MoviePageView.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
    func setTitle(_ text: String)
    func showPoster(named: String?)
}

class MoviePageView: UIViewController {
        
    var presenter: MoviePagePresenterProtocol!
    
    private lazy var posterView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private lazy var playButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.setBackgroundImage(.playBtn, for: .normal)
        $0.layer.cornerRadius = 20
        return $0
    }(UIButton(primaryAction: actionPlay))
    
    lazy var actionPlay = UIAction { [weak self] _ in
        guard let self = self,
              let tabBarVC = self.tabBarController as? TabBarView else { return }
        tabBarVC.selectedIndex = 1
        tabBarVC.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(posterView)
        view.addSubview(playButton)
        
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 0.9),
            
            playButton.topAnchor.constraint(equalTo: posterView.centerYAnchor),
            playButton.leadingAnchor.constraint(equalTo: posterView.centerXAnchor,constant: -25),
            
        ])
    }
    
}

extension MoviePageView: MoviePageViewProtocol {
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }

    func showPoster(named: String?) {
        if let name = named {
            posterView.image = UIImage(named: name)
        }
    }
    
}

extension MoviePageView {
    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.appWhite,
            .font: UIFont.systemFont(ofSize: 20, weight: .black)
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
            style: .plain,
            target: self,
            action: #selector(didTapBack))
        navigationItem.leftBarButtonItem?.tintColor = .appWhite
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
    }
}
