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
}

class ActorPageView: UIViewController {
    var presenter: ActorPagePresenterProtocol!
    
    private var sections: [ActorPageCollectionSection] = []
    
    private var selectedSegmentedTabsIndex: Int = 0
    private var isBiographyExpanded = false
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(ActorHeaderCell.self, forCellWithReuseIdentifier: ActorHeaderCell.reuseId)
        $0.register(ActorStackButtonsCell.self, forCellWithReuseIdentifier: ActorStackButtonsCell.reuseId)
        $0.register(ActorSegmentedTabsCell.self, forCellWithReuseIdentifier: ActorSegmentedTabsCell.reuseId)
        $0.register(ActorFilmographyCell.self, forCellWithReuseIdentifier: ActorFilmographyCell.reuseId)
        $0.register(ActorOverviewCell.self, forCellWithReuseIdentifier: ActorOverviewCell.reuseId)
        $0.register(ActorGalleryImageCell.self, forCellWithReuseIdentifier: ActorGalleryImageCell.reuseId)
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
                
            case .biography:
                return ActorPageLayoutFactory.setBiographyLayout()
                
            case .gallery:
                return ActorPageLayoutFactory.setGalleryLayout()
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
        edgesForExtendedLayout = [.top]
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
    
    // MARK: - Animation showZoomedImage
    private func showZoomedImage(from cell: UICollectionViewCell, image: UIImage) {
        
        let startFrame = cell.convert(cell.bounds, to: view)
        
        let zoomImageView = UIImageView(image: image)
        zoomImageView.frame = startFrame
        zoomImageView.contentMode = .scaleAspectFit
        zoomImageView.backgroundColor = .clear
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.tag = 33
        
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
        backgroundView.alpha = 0
        backgroundView.tag = 32
        
        view.addSubview(backgroundView)
        view.addSubview(zoomImageView)
        
        UIView.animate(withDuration: 0.4) {
            backgroundView.alpha = 1
            
            let insetBounds = self.view.bounds.insetBy(dx: 20, dy: 80)
            zoomImageView.frame = insetBounds
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissZoomedImage))
        zoomImageView.addGestureRecognizer(tap)
    }
    
    // MARK: - Animation dismissZoomedImage
    @objc private func dismissZoomedImage(_ sender: UITapGestureRecognizer) {
        
        guard let zoomImageView = view.viewWithTag(33) as? UIImageView,
              
              let backgroundView = view.viewWithTag(32) else { return }
        
        UIView.animate(withDuration: 0.4, animations: {
            backgroundView.alpha = 0
            zoomImageView.alpha = 0
        }, completion: { _ in
            zoomImageView.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }
}

extension ActorPageView: UICollectionViewDataSource {
    
    //MARK: numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    //MARK: numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        sections[section].items.count
        
        switch sections[section].type {
        case .socialStackButtons:
            return 1
        case .actorSegmentedTabs:
            return 1
        default:
            return sections[section].items.count
        }
    }
    
    //MARK: cellForItemAt
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
            
        case .biography:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorOverviewCell.reuseId, for: indexPath) as? ActorOverviewCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .biography(let detailsVM):
                cell.configureActorOverviewCell(with: detailsVM.biography, expanded: isBiographyExpanded)
                cell.delegate = self
            default: break
            }
            return cell
            
        case .gallery:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorGalleryImageCell.reuseId, for: indexPath) as? ActorGalleryImageCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .gallery(let imageVM):
                cell.configureGalleryImageCell(with: imageVM)
            default: break
            }
            return cell
        }
    }
    
}

//MARK: ActorSegmentedTabsCellDelegate
extension ActorPageView: ActorSegmentedTabsCellDelegate {
    func didSelectTab(index: Int) {
        presenter.didActorSelectTab(index: index)
    }
}

//MARK: ActorOverviewCellDelegate
extension ActorPageView: ActorOverviewCellDelegate {
    func actorOverviewCellDidToggle(_ cell: ActorOverviewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        isBiographyExpanded.toggle()
        
        // перезагрузка ячейки — compositional layout пересчитает высоту (estimated)
        collectionView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
}

//MARK: didSelectItemAt
extension ActorPageView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard sections.indices.contains(indexPath.section),
              sections[indexPath.section].items.indices.contains(indexPath.item)
        else { return }
        
        let item = sections[indexPath.section].items[indexPath.item]
        
        switch item {
        case .filmography(let movieVM):
            presenter.didSelectFilmographyMovie(movieVM)
            
        case .gallery:
            if let cell = collectionView.cellForItem(at: indexPath) as? ActorGalleryImageCell,
               let image = cell.image {
                showZoomedImage(from: cell, image: image)
            }
            
        default:
            break
        }
    }
}

//MARK: ActorPageViewProtocol
extension ActorPageView: ActorPageViewProtocol {

    func showActorSections(sections: [ActorPageCollectionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
}
