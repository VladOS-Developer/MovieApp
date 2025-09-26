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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
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
    
    func configureListCell(with movieVM: MovieCellViewModel ) {
        posterImage.image = movieVM.posterImage
        voteAverageLabel.text = movieVM.ratingText
        movieId = movieVM.id
        
        let posterName = movieVM.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: posterName), for: .normal)
        favoriteButton.tintColor = .systemRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
