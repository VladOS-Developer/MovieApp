//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

// MARK: - MainScreenViewProtocol

protocol MainScreenViewProtocol: AnyObject {
    func showMovies(sections: [MainCollectionSection])
    func reloadSearchResultsSection(with items: [MainCollectionItem])
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    private var sections: [MainCollectionSection] = []
    
    // MARK: - TMDB Attribution View
    
    private let tmdbAttributionView: UIStackView = {
        let logo = UIImageView(image: UIImage(named: "tmdbLogo"))
        logo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logo.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = "Data provided by TMDB"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .appGray
        
        let stack = UIStackView(arrangedSubviews: [logo, label])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - UIcollectionView
    
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
        $0.register(TVSeriesCell.self, forCellWithReuseIdentifier: TVSeriesCell.reuseId)
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
                
            case .tvSeries:
                return MainScreenLayoutFactory.setTVSeriesLayout()
                
            case .upcomingMovie:
                return MainScreenLayoutFactory.setUpcomingMovieLayout()
                
            }
        }
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(tmdbAttributionView)
        tmdbAttributionView.translatesAutoresizingMaskIntoConstraints = false
        edgesForExtendedLayout = [.top]
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tmdbAttributionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tmdbAttributionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20)
        ])
        presenter.getMoviesData()
    }
}

// MARK: - UICollectionViewDataSource

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
            
            cell.onCancelTapped = { [weak self] in
                self?.presenter.didUpdateSearchQuery("")
            }
            
            cell.onSettingsTapped = { [weak self] in
                self?.presenter.didTapSettings()
            }
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
            
        case .tvSeries:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCell.reuseId, for: indexPath) as? TVSeriesCell else {
                return UICollectionViewCell()
            }
            
            switch item {
            case .tvSeries(let seriesVM):
                cell.configureTVSeriesCell(with: seriesVM)
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
    
    
    // MARK: - viewForSupplementaryElementOfKind
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.reuseId, for: indexPath) as? MainSectionHeaderView else {
            return UICollectionReusableView()
        }
        
        let section = sections[indexPath.section]
        
        let showSeeAll = section.type == .topMovie || section.type == .upcomingMovie || section.type == .tvSeries
        header.setHeaderView(with: section.type.title, showsButton: showSeeAll)
        
        header.sectionIndex = indexPath.section
        header.delegate = self
        return header
    }
    
}

// MARK: - UICollectionViewDelegate

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

// MARK: - MainSectionHeaderViewDelegate

extension MainScreenView: MainSectionHeaderViewDelegate {
    func didTapSeeAllButton(in section: Int) {
        presenter.didTapSeeAll(in: section)
    }
}

// MARK: - GenreMovieCellDelegate

extension MainScreenView: GenreMovieCellDelegate {
    func didTapGenre(id: Int, title: String) {
        presenter.didSelectGenre(id: id, title: title)
    }
}

// MARK: - MainScreenViewProtocol

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
    }
    
    func showMovies(sections: [MainCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

