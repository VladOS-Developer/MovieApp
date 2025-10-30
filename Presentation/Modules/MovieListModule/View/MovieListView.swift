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
    func updateSeries(_ series: [TVSeriesCellViewModel])
    func updateFavoriteState(at index: Int, isFavorite: Bool)
}

class MovieListView: UIViewController {
    
    var presenter: MovieListPresenterProtocol!
    private var movies: [MovieCellViewModel] = []
    private var series: [TVSeriesCellViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
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
        configureNavBarWithBackButton(title: title, backAction: #selector(didTapBack))
        view.addSubview(collectionView)
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        (presenter as? MovieListPresenter)?.viewWillAppear()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension MovieListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !series.isEmpty ? series.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reuseId, for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }
        
        if !series.isEmpty {
            cell.configureListCell(with: series[indexPath.item])
        } else {
            cell.configureListCell(with: movies[indexPath.item])
        }
        
        cell.onFavoriteTapped = { [weak self] id in
            (self?.presenter as? MovieListPresenter)?.toggleFavorite(for: id)
        }
        
        return cell
    }
}

extension MovieListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.item)
    }
}

extension MovieListView: MovieListViewProtocol {
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func updateMovies(_ movies: [MovieCellViewModel]) {
        self.movies = movies
        Task { @MainActor in
            collectionView.reloadData()
        }
    }
    func updateSeries(_ series: [TVSeriesCellViewModel]) {
        self.series = series
        Task { @MainActor in
            collectionView.reloadData()
        }
    }
    
    func updateFavoriteState(at index: Int, isFavorite: Bool) {
        Task { @MainActor in
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? MovieListCell {
                cell.setFavoriteState(isFavorite)
            }
        }
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
