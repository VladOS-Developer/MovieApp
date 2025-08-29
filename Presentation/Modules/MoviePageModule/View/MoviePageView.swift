//
//  MoviePageView.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
    func showMovie(sections: [PageCollectionSection])
    func navigateToTrailerPalyer()
}

class MoviePageView: UIViewController {
        
    var presenter: MoviePagePresenterProtocol!
    private var sections: [PageCollectionSection] = []
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseId)
        $0.register(StackButtonsCell.self, forCellWithReuseIdentifier: StackButtonsCell.reuseId)
        $0.register(SpecificationCell.self, forCellWithReuseIdentifier: SpecificationCell.reuseId)
        $0.register(MovieVideoCell.self, forCellWithReuseIdentifier: MovieVideoCell.reuseId)
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
            case .videoMovie:
                return MoviePageLayoutFactory.setMovieVideoLayout()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        navigationController?.isNavigationBarHidden = true // решить вопрос навигации
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
            case .movie(let movieVM):
                cell.configurePosterCell(with: movieVM)
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
            case .movie(let movieVM):
                cell.configureSpecificationCell(with: movieVM)
            default: break
            }
            return cell
            
        case .videoMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieVideoCell.reuseId, for: indexPath) as? MovieVideoCell else {
                return UICollectionViewCell()
            }
            
            let item = section.items[indexPath.item]
            switch item {
            case .video(let movieVM):
                cell.configureMovieVideoCell(with: movieVM)
            default: break
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
    
    func navigateToTrailerPalyer() {
        let trailerPlayerVC = Builder.createTrailerPlayerController()
        present(trailerPlayerVC, animated: true)
    }
    
}

extension MoviePageView: PosterCellDelegate {
    func didTapPlayButton(in cell: PosterCell) {
        presenter.didTapPlayTrailerButton()
    }
}

extension MoviePageView: UICollectionViewDelegate {
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

    
