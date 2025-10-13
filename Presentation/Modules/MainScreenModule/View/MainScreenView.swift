//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showMovies(sections: [MainCollectionSection])
    func reloadSearchResultsSection(with items: [MainCollectionItem])
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    private var sections: [MainCollectionSection] = []
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(GenreMovieCell.self, forCellWithReuseIdentifier: GenreMovieCell.reuseId)
        $0.register(TopMovieCell.self, forCellWithReuseIdentifier: TopMovieCell.reuseId)
        $0.register(UpcomingMovieCell.self, forCellWithReuseIdentifier: UpcomingMovieCell.reuseId)
        $0.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.reuseId)
        $0.register(SearchHeaderCell.self, forCellWithReuseIdentifier: SearchHeaderCell.reuseId)
        $0.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createLayout()))
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .searchHeader:
                return MainScreenLayoutFactory.setSearchHeaderLayout()
                
            case .searchResults:
                return MainScreenLayoutFactory.setSearchResultLayout()
                
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        edgesForExtendedLayout = [.top]
      
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        presenter.getMoviesData()
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
            
        case .searchHeader:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchHeaderCell.reuseId, for: indexPath) as? SearchHeaderCell else {
                return UICollectionViewCell()
            }
            cell.onTextChanged = { [weak self] text in
                self?.presenter.didUpdateSearchQuery(text)
            }
            
//            cell.onSearchTapped = { [weak self] in
//                 self?.presenter.didTapSearch()
//            }
//            cell.onSettingsTapped = { [weak self] in
//                // self?.presenter.didTapSettings() (навигация в новый модуль)
//            }
            return cell
            
        case .searchResults:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reuseId, for: indexPath) as? SearchResultCell else {
                return UICollectionViewCell()
            }
            
            if case .movie(let vm) = item {
                cell.configureResultCell(with: vm)
            }
            return cell
            
        case .genresMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreMovieCell.reuseId, for: indexPath) as? GenreMovieCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            
            switch item {
            case .genre(let genreVM):
                cell.configureGenreCell(id: genreVM.id, title: genreVM.name) // ПРОВЕРИТЬ
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
        
        header.sectionIndex = indexPath.section
        header.delegate = self
        return header
    }
    
}

extension MainScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        
        switch section.type {
        case .topMovie, .upcomingMovie, .searchResults:
            let item = section.items[indexPath.item]
            
            if case .movie(let vm) = item {
                presenter.didSelectMovie(with: vm.id, title: vm.title)
            }
        default:
            break
        }
    }
}

extension MainScreenView: MainSectionHeaderViewDelegate {
    func didTapSeeAllButton(in section: Int) {
        presenter.didTapSeeAll(in: section)
    }
}

extension MainScreenView: GenreMovieCellDelegate {
    func didTapGenre(id: Int, title: String) {
        presenter.didSelectGenre(id: id, title: title)
    }
}

extension MainScreenView: MainScreenViewProtocol {
    
    func reloadSearchResultsSection(with items: [MainCollectionItem]) {
        // Обновляем модель секций локально
        if let index = sections.firstIndex(where: { $0.type == .searchResults }) {
            sections[index] = MainCollectionSection(type: .searchResults, items: items)
            // Перезагружаем только эту секцию
            collectionView.performBatchUpdates {
                collectionView.reloadSections(IndexSet(integer: index))
            }
            // Если секция видимая и нужен переход слоя layout
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
//        if let tabBarVC = tabBarController as? TabBarView {
//            let shouldHide = !items.isEmpty
//            tabBarVC.setTabBarButtonsHidden(shouldHide)
//        }
    }
    
    func showMovies(sections: [MainCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

