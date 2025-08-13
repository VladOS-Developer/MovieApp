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
//        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
       
        let button = UIButton(configuration: config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.appWhite, for: .normal)
        button.backgroundColor = .appGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
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
            genreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -6),
            genreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let fittingSize = contentView.systemLayoutSizeFitting(CGSize(width: UIView.noIntrinsicMetric, height: layoutAttributes.size.height))
        layoutAttributes.frame.size.width = fittingSize.width
        return layoutAttributes
    }
    
    func configureGenreCell(with genreVM: GenreCellViewModel) {
        genreButton.setTitle(genreVM.name, for: .normal)
//        genreButton.tag = genre.id // пригодиться при обработке
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
