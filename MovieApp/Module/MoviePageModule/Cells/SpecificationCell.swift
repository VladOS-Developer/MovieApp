//
//  SpecificationCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

class SpecificationCell: UICollectionViewCell {
    
    static let reuseId = "SpecificationCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func configureSpecificationCell(with movieVM: MovieCellViewModel) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
