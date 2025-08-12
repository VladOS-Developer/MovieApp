//
//  MainScreenLayoutFactory.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

enum MainScreenLayoutFactory {
    
    static func setGenreMovieLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:.init(widthDimension: .estimated(70), heightDimension: .absolute(35)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(70), heightDimension: .absolute(35)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func setTopMovieLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .estimated(220)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
       
    }
   
    static func setUpcomingMovieLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(280), heightDimension: .estimated(180)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 25, leading: 16, bottom: 0, trailing: 16)
        return section
    }
}
