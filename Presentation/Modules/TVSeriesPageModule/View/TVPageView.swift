//
//  TVPageView.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVPageViewProtocol: AnyObject {
    func showTV(sections: [TVPageCollectionSection])
    func updateFavoriteState(isFavorite: Bool)
    func setTitle(_ text: String)
}

class TVPageView: UIViewController {
    
    var presenter: TVPagePresenterProtocol!
    private var sections: [TVPageCollectionSection] = []
    private var isOverviewExpanded = false
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(PosterTVCell.self, forCellWithReuseIdentifier: PosterTVCell.reuseId)
        $0.register(StackButtonsTVCell.self, forCellWithReuseIdentifier: StackButtonsTVCell.reuseId)
        $0.register(SpecificationTVCell.self, forCellWithReuseIdentifier: SpecificationTVCell.reuseId)
        $0.register(OverviewTVCell.self, forCellWithReuseIdentifier: OverviewTVCell.reuseId)
        $0.register(VideoTVCell.self, forCellWithReuseIdentifier: VideoTVCell.reuseId)
        $0.register(SegmentedTabsTVCell.self, forCellWithReuseIdentifier: SegmentedTabsTVCell.reuseId)
        $0.register(SimilarMovieTVCell.self, forCellWithReuseIdentifier: SimilarMovieTVCell.reuseId)
        $0.register(AboutTVCell.self, forCellWithReuseIdentifier: AboutTVCell.reuseId)
        $0.register(SegmentedEpisodesTVCell.self, forCellWithReuseIdentifier: SegmentedEpisodesTVCell.reuseId)
        $0.register(EpisodeVideoTVCell.self, forCellWithReuseIdentifier: EpisodeVideoTVCell.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createPageLayout()))
    
    private func createPageLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .posterTV:
                return TVPageLayoutFactory.setPosterTVLayout()
                
            case .stackButtonsTV:
                return TVPageLayoutFactory.setStackButtonTVLayout()
                
            case .specificationTV:
                return TVPageLayoutFactory.setSpecificationTVLayout()
                
            case .overviewTV:
                return TVPageLayoutFactory.setOverviewTVLayout()
                
            case .videoTV:
                return TVPageLayoutFactory.setVideoTVLayout()
                
            case .episodesSegmentTV:
                return TVPageLayoutFactory.setSegmentedEpisodesLayout()
                
            case .episodeVideosTV:
                return TVPageLayoutFactory.setEpisodeVideosLayout()
                
            case .segmentedTabsTV:
                return TVPageLayoutFactory.setSegmentedTabsTVLayout()
             
            case .dynamicContentTV:
                return TVPageLayoutFactory.setDynamicContentTVLayout()
            
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
        edgesForExtendedLayout = [.top, .bottom]
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        presenter.getTVData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        if !(navigationController?.topViewController is ActorPageView) {
            (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
        }
    }
    
    @objc private func didTapHeart() {
        presenter.toggleFavorite()
    }
    
}

extension TVPageView: UICollectionViewDataSource {
    
    // MARK: - updateFavoriteState
    
    func updateFavoriteState(isFavorite: Bool) {
        let systemName = isFavorite ? "heart.fill" : "heart"
        
        Task { @MainActor in
            navigationItem.rightBarButtonItem?.image = UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
            )
        }
    }
    
    // MARK: - numberOfSections
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    // MARK: - numberOfItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        sections[section].items.count
        switch sections[section].type {
        case .stackButtonsTV:
            return 1 // возврат 1
        case .episodesSegmentTV:
            return 1
        case .segmentedTabsTV:
            return 1
        default:
            return sections[section].items.count
        }
    }
    
    // MARK: - cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        // let item = section.items[indexPath.item] // тут передача пустого массива для stackButtons (краш) секция думает что у неё 1 айтем → коллекция спрашивает items[0] → а массив пустой → краш.
        
        switch section.type {
            
            // PosterMovie
        case .posterTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterTVCell.reuseId, for: indexPath) as? PosterTVCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            let item = section.items[indexPath.item] // тут безопасно дергать items, есть данные
            
            switch item {
            case .tvDetails(let detailsVM):
                cell.configureTVPosterCell(with: detailsVM)
            default: break
            }
            return cell
            
            // StackButtons
        case .stackButtonsTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StackButtonsTVCell.reuseId, for: indexPath) as? StackButtonsTVCell else {
                return UICollectionViewCell()
            }
            return cell
            
            // SpecificationMovie
        case .specificationTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificationTVCell.reuseId, for: indexPath) as? SpecificationTVCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .tvDetails(let detailsVM):
                cell.configureTVSpecificationCell(with: detailsVM)
            default: break
            }
            return cell
            
            // OverviewMovie
        case .overviewTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewTVCell.reuseId, for: indexPath) as? OverviewTVCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .tvDetails(let detailsVM):
                cell.configureTVOverviewCell(with: detailsVM.overview ?? "", expanded: isOverviewExpanded)
                cell.delegate = self
            default: break
            }
            return cell
            
            // VideoMovie
        case .videoTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoTVCell.reuseId, for: indexPath) as? VideoTVCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            let item = section.items[indexPath.item]
            switch item {
            case .tvVideo(let videoVM):
                cell.configureTVVideoCell(with: videoVM)
            default: break
            }
            return cell
            
            // EpisodesSegmentTV
        case .episodesSegmentTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedEpisodesTVCell.reuseId, for: indexPath) as? SegmentedEpisodesTVCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
            
        case .episodeVideosTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeVideoTVCell.reuseId, for: indexPath) as? EpisodeVideoTVCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .tvEpisodeVideo(let videoVM):
                cell.configureEpisodeVM(with: videoVM)
            default: break
            }
            cell.delegate = self
            
            return cell
            
            // SegmentedTabs
        case .segmentedTabsTV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedTabsTVCell.reuseId, for: indexPath) as? SegmentedTabsTVCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            return cell
            
            // DynamicContent
        case .dynamicContentTV:
            let item = section.items[indexPath.item]
            
            switch item {
            case .tvSimilar(let similarVM):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieTVCell.reuseId, for: indexPath) as? SimilarMovieTVCell else {
                    return UICollectionViewCell()
                }
                cell.configureTVSimilarMovieCell(with: similarVM)
                return cell
                
            case .tvCast(let castVM):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutTVCell.reuseId, for: indexPath) as? AboutTVCell else {
                    return UICollectionViewCell()
                }
                cell.configureTVAboutCell(with: castVM)
                cell.delegate = self
                return cell
                
            default:
                return UICollectionViewCell()
                
            }
        
        }
    }
    
}

// MARK: - SegmentedEpisodesTVCell
extension TVPageView: SegmentedEpisodesTVCellDelegate {
    func didSelectSeason(index: Int) {
        presenter.didSelectSeason(index: index)
    }
}



// MARK: - SegmentedTabsCell
extension TVPageView: SegmentedTabsTVCellDelegate {
    func didSelectTab(index: Int) {
        presenter.didSelectTab(index: index)
    }
}

//MARK: - didSelectItemAt

extension TVPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard sections.indices.contains(indexPath.section),
              sections[indexPath.section].items.indices.contains(indexPath.item)
        else { return }
        
        let item = sections[indexPath.section].items[indexPath.item]
        
        switch item {
        case .tvSimilar(let similarVM):
            presenter.didSelectSimilarMovie(similarVM)
        default:
            break
        }
    }
}

//MARK: - TVPageViewProtocol

extension TVPageView: TVPageViewProtocol {
    
    func showTV(sections: [TVPageCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
}

//MARK: - AboutTVCellDelegate +

extension TVPageView: AboutTVCellDelegate {
    func aboutTVCellDidTapProfileImage(_ cell: AboutTVCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              case .tvCast(let castVM) = sections[indexPath.section].items[indexPath.item] else { return }
        
        presenter.didSelectActor(castVM: castVM)
    }
}

//MARK: - PosterTVCellDelegate +

extension TVPageView: PosterTVCellDelegate {
    func didTapPlayButton(in cell: PosterTVCell) {
        presenter.playPosterTrailer()
    }
}

//MARK: - EpisodeVideoTVCellDelegate +

extension TVPageView: EpisodeVideoTVCellDelegate {
    func didTapPlayButton(in cell: EpisodeVideoTVCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              case .tvEpisodeVideo(let videoVM) = sections[indexPath.section].items[indexPath.item] else { return }
        
        print("Episode play tapped: \(videoVM.name) id:\(videoVM.id) key:\(videoVM.videoKey)")
        presenter.didTapPlayEpisodeButton(videoVM: videoVM)
    }
}

//MARK: - VideoTVCellDelegate +

extension TVPageView: VideoTVCellDelegate {
    func didTapPlayButton(in cell: VideoTVCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              case .tvVideo(let videoVM) = sections[indexPath.section].items[indexPath.item] else { return }
        
        presenter.didTapPlayTrailerButton(videoVM: videoVM)
    }
}

//MARK: - OverviewTVCellDelegate +

extension TVPageView: OverviewTVCellDelegate {
    func overviewCellDidToggle(_ cell: OverviewTVCell) {
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


