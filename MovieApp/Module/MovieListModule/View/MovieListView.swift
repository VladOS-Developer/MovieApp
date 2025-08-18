//
//  MovieListView.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    func setTitle(_ text: String)
    func updateMovies(_ movies: [MovieCellViewModel])
}

class MovieListView: UIViewController {
    
    var presenter: MovieListPresenterProtocol!
    private var movies: [MovieCellViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        let itemSize = ((view.bounds.width - 40) / 2) - 12
        //        layout.itemSize = CGSize(width: itemSize, height: 200)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 22
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.reuseId)
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(collectionView)
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
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
        print("TabBar появился")
    }
    
}

extension MovieListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reuseId, for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }
        let movieVM = movies[indexPath.item]
        cell.configureListCell(with: movieVM)
        return cell
    }
}

extension MovieListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 22
        let totalSpacing = spacing * (columns - 1) + 40 // sectionInsets left+right = 20+20
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: floor(width), height: floor(width * 1.2))
    }
}

extension MovieListView: MovieListViewProtocol {
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func updateMovies(_ movies: [MovieCellViewModel]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
}
