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

class MoviePageView: UIViewController {
        
    var presenter: MoviePagePresenterProtocol!
    private var sections: [PageCollectionSection] = []
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createPageLayout()))
    
    private func createPageLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] section, _ in
            let currentSection = sections[section]
            
            switch currentSection.type {
            case .posterMovie:
                return MoviePageLayoutFactory.setPosterMovieLayout()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.isNavigationBarHidden = true
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
        presenter.getMoviesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
    }

}

extension MoviePageView: UICollectionViewDataSource {
    
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
            
        case .posterMovie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseId, for: indexPath) as? PosterCell else {
                return UICollectionViewCell()
            }
            switch item {
            case .movie(let movieVM):
                cell.configurePosterCell(with: movieVM)
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
}


    
