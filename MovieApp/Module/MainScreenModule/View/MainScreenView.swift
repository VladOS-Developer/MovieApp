//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showMovies(sections: [CollectionSection])
    func navigationToDynamicScreen()
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    private var sections: [CollectionSection] = []
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.register(GenreMovieCell.self, forCellWithReuseIdentifier: GenreMovieCell.reuseId)
        $0.register(TopMovieCell.self, forCellWithReuseIdentifier: TopMovieCell.reuseId)
        $0.register(UpcomingMovieCell.self, forCellWithReuseIdentifier: UpcomingMovieCell.reuseId)
        $0.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.reuseId)
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
            
            switch item {
            case .movie(let movieVM):
                cell.configureMovieCell(with: movieVM)
            default: break
            }
            
            return cell
            
        case .upcomingMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCell.reuseId, for: indexPath) as? UpcomingMovieCell else {
                return UICollectionViewCell()
            }
            
            switch item {
            case.movie(let movieVM):
                cell.configureUpcomingCell(with: movieVM)
            default: break
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.reuseId, for: indexPath) as? MainSectionHeaderView else {
            return UICollectionReusableView()
        }
        
        let section = sections[indexPath.section]
        
        let showSeeAll = section.type == .topMovie || section.type == .upcomingMovie
        
        header.setHeaderView(with: section.type.title, showsButton: showSeeAll)
        header.delegate = self
        return header
    }
    
}

extension MainScreenView: MainScreenViewProtocol {
    
    func navigationToDynamicScreen() {
//        if let tabBarVC = self.tabBarController as? TabBarView {
//            tabBarVC.selectedIndex = 2
//        }
    }
    
    func showMovies(sections: [CollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
}

extension MainScreenView: MainSectionHeaderViewProtocol {
    func didTapSeeAllButton(in section: Int) {
//        presenter.didTapSeeAll(in: section)
//        print("Navigation from section: \(section), TabBar скрылся")
    }
    
    
}
