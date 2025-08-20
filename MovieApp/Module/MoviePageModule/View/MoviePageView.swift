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
        $0.backgroundColor = .appBlue.withAlphaComponent(0.2)
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
    
    private lazy var buttonStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(posterView)
        view.addSubview(playButton)
        view.addSubview(buttonStack)
        configureStackButtons()
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
            playButton.leadingAnchor.constraint(equalTo: posterView.centerXAnchor,constant: -20),
            
            buttonStack.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 30),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            
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
        navigationItem.leftBarButtonItem?.tintColor = .appBlue
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
    }
    
    private func configureStackButtons() {
        let actions: [(String, Selector)] = [
            ("heartWhite", #selector(didTapHeart)),
            ("favoritesWhite", #selector(didTapFavorite)),
            ("telegram", #selector(didTapShare))
        ]
        
        actions.forEach { (name, selector) in
            let button = UIButton(type: .custom)
            button.setBackgroundImage(UIImage(named: name), for: .normal)
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            buttonStack.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapHeart() { print("Heart tapped") }
    @objc private func didTapFavorite() { print("Favorite tapped") }
    @objc private func didTapShare() { print("Share tapped") }
}
