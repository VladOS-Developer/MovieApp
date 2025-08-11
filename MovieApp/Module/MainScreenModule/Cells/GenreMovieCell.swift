//
//  GenreMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

class GenreMovieCell: UICollectionViewCell {
    
    static let reuseId = "GenreMovieCell"
    
    lazy var genreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
//        config.background.backgroundColor = .appGray.withAlphaComponent(0.2)
//        config.background.cornerRadius = 15
//        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.appWhite, for: .normal)
        button.backgroundColor = .appGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(genreButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            genreButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            genreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureGenreCell(with genreVM: GenreCellViewModel) {
        genreButton.setTitle(genreVM.name, for: .normal)
//        genreButton.tag = genre.id // пригодиться при обработке
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
