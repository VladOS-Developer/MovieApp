//
//  MovieListCell.swift
//  MovieApp
//
//  Created by VladOS on 17.08.2025.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    static let reuseId = "MovieListCell"
    
    private var movieId: Int = 0
    var onFavoriteTapped: ((Int) -> Void)?
 
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
        $0.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc private func favoriteTapped() {
        onFavoriteTapped?(movieId)
    }
 
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
            favoriteButton.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -20)
        ])
    }
    
    func configureListCell(with movieVM: MovieCellViewModel ) {
        posterImage.image = movieVM.posterImage
        
        movieId = movieVM.id
        
        let imageName = movieVM.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = .systemRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
