//
//  MovieListCell.swift
//  MovieApp
//
//  Created by VladOS on 17.08.2025.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    
    static let reuseId = "MovieListCell"
    
    private lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureListCell(with movieVM: MainDetailsCellViewModel ) {
        posterImage.image = movieVM.posterImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
