//
//  MoviePageView.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
    func showMovie(sections: [PageCollectionSection])
}

class MoviePageView: UIViewController, UICollectionViewDelegate {
    
    var presenter: MoviePagePresenterProtocol!
    private var sections: [PageCollectionSection] = []
    
    private var isOverviewExpanded = false
    private var selectedTabIndex: Int = UISegmentedControl.noSegment

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
                return MoviePageLayoutFactory.setDynamicContentLayout()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//                navigationController?.isNavigationBarHidden = true // решить вопрос навигации
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
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
    
}

extension MoviePageView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        //        let item = section.items[indexPath.item] // тут передача пустого массива для stackButtons (краш) секция думает что у неё 1 айтем → коллекция спрашивает items[0] → а массив пустой → краш.
        
        switch section.type {
            
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
            
        case .stackButtons:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StackButtonsCell.reuseId, for: indexPath) as? StackButtonsCell else {
                return UICollectionViewCell()
            }
            return cell
            
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
            
        case .segmentedTabs:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedTabsCell.reuseId, for: indexPath) as? SegmentedTabsCell else {
                return UICollectionViewCell()
            }
            // передаём выбранный индекс, чтобы состояние не сбрасывалось при перезагрузках
//            cell.configureSegmentedTabsCell(selectedIndex: selectedTabIndex) ???
            cell.onTabSelected = { [weak self] idx in
                self?.presenter.didSelectTab(index: idx)
            }
            return cell
            
        case .dynamicContent:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.reuseId, for: indexPath) as? SimilarMovieCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            if case .similarMovie(let similarVM) = item {
                cell.configureSimilarMovieCell(with: similarVM)
            }
            
            return cell
        }
    }
    
}

extension MoviePageView: MoviePageViewProtocol {
    func showMovie(sections: [PageCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

extension MoviePageView: PosterCellDelegate {
    func didTapPlayButton(in cell: PosterCell) {
        presenter.didTapPlayTrailerButton()
    }
}

extension MoviePageView: MovieVideoCellDelegate {
    func didTapPlayButton(in cell: MovieVideoCell) {
        presenter.didTapPlayTrailerButton()
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
        navigationItem.leftBarButtonItem?.tintColor = .appWhite
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }

}

    
