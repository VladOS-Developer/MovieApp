//
//  TopMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

final class TopMovieCell: UICollectionViewCell {
    static let reuseId = "TopMovieCell"
    
    private lazy var imageViewMovie: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var titleLabel: UILabel = TextLabel(font: .systemFont(ofSize: 10, weight: .bold), color: .appWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageViewMovie)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewMovie.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewMovie.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configureMovieCell(with movieVM: MovieCellViewModel) {
        imageViewMovie.image = movieVM.posterImage
        titleLabel.text = movieVM.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
