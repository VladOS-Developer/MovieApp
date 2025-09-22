//
//  MoviePageView.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
    func showMovie(sections: [PageCollectionSection])
    func updateFavoriteState(isFavorite: Bool)
    func setSelectedTabIndex(_ index: Int)
    func setTitle(_ text: String)
}

class MoviePageView: UIViewController {
    
    var presenter: MoviePagePresenterProtocol!
    private var sections: [PageCollectionSection] = []
    private var isOverviewExpanded = false
    private var selectedSegmentedTabsIndex: Int = 0

    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseId)
        $0.register(StackButtonsCell.self, forCellWithReuseIdentifier: StackButtonsCell.reuseId)
        $0.register(SpecificationCell.self, forCellWithReuseIdentifier: SpecificationCell.reuseId)
        $0.register(OverviewCell.self, forCellWithReuseIdentifier: OverviewCell.reuseId)
        $0.register(MovieVideoCell.self, forCellWithReuseIdentifier: MovieVideoCell.reuseId)
        $0.register(SegmentedTabsCell.self, forCellWithReuseIdentifier: SegmentedTabsCell.reuseId)
        $0.register(SimilarMovieCell.self, forCellWithReuseIdentifier: SimilarMovieCell.reuseId)
        $0.register(AboutCell.self, forCellWithReuseIdentifier: AboutCell.reuseId)
        $0.register(CastAndCrewHeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: CastAndCrewHeaderView.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createPageLayout()))
    
    private func createPageLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .posterMovie:
                return MoviePageLayoutFactory.setPosterMovieLayout()
                
            case .stackButtons:
                return MoviePageLayoutFactory.setStackButtonLayout()
                
            case .specificationMovie:
                return MoviePageLayoutFactory.setSpecificationLayout()
                
            case .overviewMovie:
                return MoviePageLayoutFactory.setOverviewLayout()
                
            case .videoMovie:
                return MoviePageLayoutFactory.setMovieVideoLayout()
                
            case .segmentedTabs:
                return MoviePageLayoutFactory.setSegmentedTabsLayout()
             
            case .dynamicContent:
                let includeHeader = (selectedSegmentedTabsIndex == 1) // About → Cast and Crew
                return MoviePageLayoutFactory.setDynamicContentLayout(includeHeader: includeHeader)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBarWithBackAndRightButton(title: title,
                                              backAction: #selector(didTapBack),
                                              rightSystemName: "heart",
                                              rightAction: #selector(didTapHeart))
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
    }
    
    @objc private func didTapHeart() {
        presenter.toggleFavorite()
    }
   
}

extension MoviePageView: UICollectionViewDataSource {
    
    // MARK: updateFavoriteState
    func updateFavoriteState(isFavorite: Bool) {
        let systemName = isFavorite ? "heart.fill" : "heart"
        
        Task { @MainActor in
            navigationItem.rightBarButtonItem?.image = UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
            )
        }
    }
    
    // MARK: viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader,
           sections[indexPath.section].type == .dynamicContent,selectedSegmentedTabsIndex == 1 {
             guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CastAndCrewHeaderView.reuseId,for: indexPath) as? CastAndCrewHeaderView else { return UICollectionReusableView() }
            return header
        }
        return UICollectionReusableView()
    }
    
    // MARK: numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    // MARK: numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        sections[section].items.count
        switch sections[section].type {
        case .stackButtons:
            return 1 // возврат 1
        case .segmentedTabs:
            return 1
        default:
            return sections[section].items.count
        }
    }
    
    // MARK: cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        // let item = section.items[indexPath.item] // тут передача пустого массива для stackButtons (краш) секция думает что у неё 1 айтем → коллекция спрашивает items[0] → а массив пустой → краш.
        
        switch section.type {
            
            // PosterMovie
        case .posterMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseId, for: indexPath) as? PosterCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            let item = section.items[indexPath.item] // тут безопасно дергать items, есть данные
            
            switch item {
            case .movieDet(let detailsVM):
                cell.configurePosterCell(with: detailsVM)
            default: break
            }
            return cell
            
            // StackButtons
        case .stackButtons:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StackButtonsCell.reuseId, for: indexPath) as? StackButtonsCell else {
                return UICollectionViewCell()
            }
            return cell
            
            // SpecificationMovie
        case .specificationMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificationCell.reuseId, for: indexPath) as? SpecificationCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .movieDet(let detailsVM):
                cell.configureSpecificationCell(with: detailsVM)
            default: break
            }
            return cell
            
            // OverviewMovie
        case .overviewMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCell.reuseId, for: indexPath) as? OverviewCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .movieDet(let detailsVM):
                cell.configureOverviewCell(with: detailsVM.overview ?? "", expanded: isOverviewExpanded)
                cell.delegate = self
            default: break
            }
            return cell
            
            // VideoMovie
        case .videoMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieVideoCell.reuseId, for: indexPath) as? MovieVideoCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            let item = section.items[indexPath.item]
            switch item {
            case .video(let videoVM):
                cell.configureMovieVideoCell(with: videoVM)
            default: break
            }
            return cell
            
            // SegmentedTabs
        case .segmentedTabs:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedTabsCell.reuseId, for: indexPath) as? SegmentedTabsCell else {
                return UICollectionViewCell()
            }
            
            cell.onTabSelected = { [weak self] idx in
                self?.presenter.didSelectTab(index: idx)
            }
            return cell
            
            // DynamicContent
        case .dynamicContent:
            let item = section.items[indexPath.item]
            
            switch item {
            case .similarMovie(let similarVM):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.reuseId, for: indexPath) as? SimilarMovieCell else {
                    return UICollectionViewCell()
                }
                cell.configureSimilarMovieCell(with: similarVM)
                return cell
                
            case .cast(let castVM):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCell.reuseId, for: indexPath) as? AboutCell else {
                    return UICollectionViewCell()
                }
                cell.configureAboutCell(with: castVM)
                cell.delegate = self
                return cell
                
            default:
                return UICollectionViewCell()
              
            }
        }
    }
    
}

extension MoviePageView: UICollectionViewDelegate {
    
}

extension MoviePageView: MoviePageViewProtocol {
    func showMovie(sections: [PageCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func setSelectedTabIndex(_ index: Int) {
        selectedSegmentedTabsIndex = index
        collectionView.collectionViewLayout = createPageLayout() // пересоздать layout с header
        collectionView.reloadData()
    }
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
}

extension MoviePageView: AboutCellDelegate {
    func aboutCellDidTapProfileImage(_ cell: AboutCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              case .cast(let castVM) = sections[indexPath.section].items[indexPath.item] else { return }
        
        presenter.didSelectActor(castVM: castVM)
    }
}

extension MoviePageView: PosterCellDelegate {
    func didTapPlayButton(in cell: PosterCell) {
        presenter.playPosterTrailer()
    }
}

extension MoviePageView: MovieVideoCellDelegate {
    func didTapPlayButton(in cell: MovieVideoCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              case .video(let videoVM) = sections[indexPath.section].items[indexPath.item] else { return }
        
        presenter.didTapPlayTrailerButton(videoVM: videoVM)
    }
}

extension MoviePageView: OverviewCellDelegate {
    func overviewCellDidToggle(_ cell: OverviewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        // переключениу состояния
        isOverviewExpanded.toggle()
        
        // перезагрузка ячейки — compositional layout пересчитает высоту (estimated)
        collectionView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
}

