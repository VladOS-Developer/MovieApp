//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showMovies(sections: [CollectionSection])
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    private var sections: [CollectionSection] = []
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.register(GenreMovieCell.self, forCellWithReuseIdentifier: GenreMovieCell.reuseId)
        $0.register(TopMovieCell.self, forCellWithReuseIdentifier: TopMovieCell.reuseId)
        $0.register(UpcomingMovieCell.self, forCellWithReuseIdentifier: UpcomingMovieCell.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createLayout()))
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .genresMovie:
                return MainScreenLayoutFactory.setGenreMovieLayout()
                
            case .topMovie:
                return MainScreenLayoutFactory.setTopMovieLayout()
                
            case .upcomingMovie:
                return MainScreenLayoutFactory.setUpcomingMovieLayout()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getMoviesData()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainScreenView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.item]
        
        switch section.type {
            
        case .genresMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreMovieCell.reuseId, for: indexPath) as? GenreMovieCell else {
                return UICollectionViewCell()
            }
            
            switch item {
            case .genre(let genreVM):
                cell.configureGenreCell(with: genreVM)
            default: break
            }
            
            return cell
            
        case .topMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopMovieCell.reuseId, for: indexPath) as? TopMovieCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .upcomingMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCell.reuseId, for: indexPath) as? UpcomingMovieCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
    }
    
}

extension MainScreenView: MainScreenViewProtocol {
    func showMovies(sections: [CollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    
}
