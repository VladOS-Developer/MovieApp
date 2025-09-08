//
//  FavoritesCell.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    static let reuseId = "FavoritesCell"
    
    private lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private lazy var favoriteButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
        $0.setBackgroundImage(.appHeart, for: .normal)
        return $0
    }(UIButton(primaryAction: nil))
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(favoriteButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -20),
        ])
    }
    
    func configureFavoritesCell(with favorite: FavoriteMovie) {
        if let posterName = favorite.posterPath {
            posterImage.image = UIImage(named: posterName) // локальные ассеты
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
