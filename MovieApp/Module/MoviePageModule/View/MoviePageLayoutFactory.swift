//
//  MoviePageLayoutFactory.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

enum MoviePageLayoutFactory {
    
    static func setPosterMovieLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // высота группы = 0.65 от ширины экрана (примерно как на скрине)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
