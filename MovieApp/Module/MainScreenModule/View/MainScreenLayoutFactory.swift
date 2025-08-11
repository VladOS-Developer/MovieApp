//
//  MainScreenLayoutFactory.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

enum MainScreenLayoutFactory {
    
    static func setGenreMovieLayout() -> NSCollectionLayoutSection {
                
        let item = NSCollectionLayoutItem(layoutSize:.init(widthDimension: .estimated(100), heightDimension: .absolute(40)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), subitems: [item])
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    
    static func setTopMovieLayout() -> NSCollectionLayoutSection {
        // Создаем пустой item (размер 0 на 0 — можно и минимальный)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Группа с высотой 1, чтобы секция занимала минимум места (или можно 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
    }
    
    static func setUpcomingMovieLayout() -> NSCollectionLayoutSection {
        // Создаем пустой item (размер 0 на 0 — можно и минимальный)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Группа с высотой 1, чтобы секция занимала минимум места (или можно 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
    }
}
