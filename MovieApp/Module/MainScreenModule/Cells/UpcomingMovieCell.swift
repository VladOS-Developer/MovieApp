//
//  UpcomingMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

class UpcomingMovieCell: UICollectionViewCell {
    
    static let reuseId = "UpcomingMovieCell"
    
    private lazy var imageUpcomingView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var titleLabel: UILabel = CellLabel(font: .systemFont(ofSize: 15, weight: .bold), color: .appWhite)
    
    private lazy var releaseDate: UILabel = CellLabel(font: .systemFont(ofSize: 10, weight: .regular), color: .appWhite)
    
    private lazy var genreLabel: UILabel = CellLabel(font: .systemFont(ofSize: 10, weight: .regular), color: .appWhite)
    
    private lazy var stackLabel: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 110
        return $0
    }(UIStackView(arrangedSubviews: [genreLabel, releaseDate]))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageUpcomingView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageUpcomingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageUpcomingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageUpcomingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageUpcomingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageUpcomingView.bottomAnchor, constant: -55),
            
            stackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackLabel.bottomAnchor.constraint(equalTo: imageUpcomingView.bottomAnchor, constant: -5),
        ])
    }
    
    func configureUpcomingCell(with movieVM: MovieCellViewModel) {
        imageUpcomingView.image = movieVM.posterImage
        titleLabel.text = movieVM.title
        releaseDate.text = movieVM.releaseDateText
        genreLabel.text = movieVM.genresText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
