//
//  FavoritesCell.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    static let reuseId = "FavoritesCell"
    
    private var movieId: Int32 = 0
    var onFavoriteTapped: ((Int32) -> Void)?
    
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
        $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        $0.tintColor = .systemRed
        $0.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
      
      @objc private func favoriteTapped() {
        onFavoriteTapped?(movieId)
    }
    
    private lazy var voteAverageLabel: UILabel = {
        let label = PaddingLabel(withInsets: 3, 3, 5, 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .appWhite
        label.backgroundColor = .appGray.withAlphaComponent(0.5)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(voteAverageLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 20),
            favoriteButton.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: 20),
            
            voteAverageLabel.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 20),
            voteAverageLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -20)
        ])
    }
    
    func configureFavoritesCell(with favorite: FavoriteMovie) {
        movieId = favorite.id
        
        if let posterName = favorite.posterPath {
            posterImage.image = UIImage(named: posterName) // локальные ассеты
        }
        
        if favorite.voteAverage > 0 {
                voteAverageLabel.text = String(format: "%.1f", favorite.voteAverage)
            } else {
                voteAverageLabel.text = "-"
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
