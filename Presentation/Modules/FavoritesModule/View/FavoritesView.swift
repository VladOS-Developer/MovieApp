//
//  FavoritesView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reloadFavorites()
}

class FavoritesView: UIViewController {

    var presenter: FavoritesPresenterProtocol!
    private var movies: [MovieCellViewModel] = []
    
    private lazy var sectionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.text = "Favorite Movies"
        return $0
    }(UILabel())
    
    private lazy var topBackButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
        $0.setBackgroundImage(.leftChevron, for: .normal)
        return $0
    }(UIButton(primaryAction: backButtonAction))
    
    private lazy var backButtonAction = UIAction { [weak self] _ in
        guard let self = self,
              let tabBarVC = self.tabBarController as? TabBarView else { return }
        tabBarVC.selectedIndex = 0
        tabBarVC.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }
   
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 22
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.reuseId)
        return collectionView
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topBackButton)
        view.addSubview(sectionLabel)
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        presenter.loadFavorites()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            topBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FavoritesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.reuseId, for: indexPath) as? FavoritesCell else {
            return UICollectionViewCell()
        }
        
        let favorite = presenter.favorite(at: indexPath.item)
        cell.movieId = favorite.id
        
        cell.onFavoriteTapped = { [weak self] id in
            self?.presenter.removeFavorite(id: id)
        }
        
        Task {
            let image = await presenter.image(for: favorite)
            if cell.movieId == favorite.id {
                cell.configureFavoritesCell(with: favorite, image: image)
            }
        }
        
        return cell
        
    }
}

extension FavoritesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let favorite = presenter.favorite(at: indexPath.item)
        presenter.didSelectFavorite(favorite)
    }
}

extension FavoritesView: FavoritesViewProtocol {
    
    func reloadFavorites() {
        collectionView.reloadData()
    }
    
}

extension FavoritesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 22
        let totalSpacing = spacing * (columns - 1) + 40 // sectionInsets left+right = 20+20
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: floor(width), height: floor(width * 1.5))
    }
}


