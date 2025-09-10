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
    
    private func makeView(with label: UILabel) -> UIView {
        let container = UIView()
        container.backgroundColor = .white.withAlphaComponent(0.2)
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
    private lazy var voteAverageLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .systemPurple)
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
    
    func configureListCell(with movieVM: MovieCellViewModel ) {
        posterImage.image = movieVM.posterImage
        voteAverageLabel.text = movieVM.ratingText
        movieId = movieVM.id
        
        let posterName = movieVM.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: posterName), for: .normal)
        favoriteButton.tintColor = .systemPurple
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
