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
    
    private func makeView(with label: UILabel) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemRed.withAlphaComponent(0.2)
        container.layer.cornerRadius = 5
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
        ])
        
        return container
    }
    private lazy var voteAverageLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .white)
    private lazy var voteAverageForView: UIView = makeView(with: voteAverageLabel)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(voteAverageForView)

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
            
            voteAverageForView.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -20),
            voteAverageForView.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -20)
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
