//
//  ActorPageView.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

protocol ActorPageViewProtocol: AnyObject {
    func setTitle(_ text: String)
    func showActorSections(sections: [ActorPageCollectionSection])
    func setSelectedTabIndex(_ index: Int)
}

class ActorPageView: UIViewController {
    var presenter: ActorPagePresenterProtocol!
    
    private var sections: [ActorPageCollectionSection] = []
    
    private var selectedSegmentedTabsIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
//        $0.alwaysBounceVertical = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(ActorHeaderCell.self, forCellWithReuseIdentifier: ActorHeaderCell.reuseId)
        $0.register(ActorStackButtonsCell.self, forCellWithReuseIdentifier: ActorStackButtonsCell.reuseId)
        $0.register(ActorSegmentedTabsCell.self, forCellWithReuseIdentifier: ActorSegmentedTabsCell.reuseId)
        $0.register(ActorFilmographyCell.self, forCellWithReuseIdentifier: ActorFilmographyCell.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createActorLayout()))

    private func createActorLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .header:
                return ActorPageLayoutFactory.setHeaderLayout()
          
            case .socialStackButtons:
                return ActorPageLayoutFactory.setSocialStackButtonLayout()
                
            case .actorSegmentedTabs:
                return ActorPageLayoutFactory.setActorSegmentedTabsLayout()
                
            case .filmography:
                return ActorPageLayoutFactory.setFilmographyLayout()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presenter.viewDidLoad()
        configureNavBarWithBackButton(title: navigationItem.title, backAction: #selector(didTapBack))
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension ActorPageView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        sections[section].items.count
        
        switch sections[section].type {
        case .socialStackButtons:
            return 1 // возврат 1
        case .actorSegmentedTabs:
            return 1
        default:
            return sections[section].items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
//        var item = section.items[indexPath.item] // тут передача пустого массива для stackButtons (краш) секция думает что у неё 1 айтем → коллекция спрашивает items[0] → а массив пустой → краш.
        
        switch section.type {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorHeaderCell.reuseId, for: indexPath) as? ActorHeaderCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            
            switch item {
            case .header(let headerVM):
                cell.configure(with: headerVM)
            default: break
            }
            return cell
            // ... другие секции

        case .socialStackButtons:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorStackButtonsCell.reuseId, for: indexPath) as? ActorStackButtonsCell else {
                return UICollectionViewCell()
            }
            return cell 
            
        case .actorSegmentedTabs:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorSegmentedTabsCell.reuseId, for: indexPath) as? ActorSegmentedTabsCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
            
        case .filmography:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorFilmographyCell.reuseId, for: indexPath) as? ActorFilmographyCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            
            switch item {
            case .filmography(let movieVM):
                cell.configureFilmographyMovieCell(with: movieVM)
            default: break
            }
            return cell
        }
    }
    
}

extension ActorPageView: ActorSegmentedTabsCellDelegate {
    func didSelectTab(index: Int) {
        presenter.didActorSelectTab(index: index)
    }
}

extension ActorPageView: UICollectionViewDelegate {
    
}

extension ActorPageView: ActorPageViewProtocol {
    func setSelectedTabIndex(_ index: Int) {
        
    }
    
    func showActorSections(sections: [ActorPageCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
}
