//
//  GenreMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

protocol GenreMovieCellDelegate: AnyObject {
    func didTapGenre(id: Int, title: String)
}

final class GenreMovieCell: UICollectionViewCell {
    static let reuseId = "GenreMovieCell"
    
    weak var delegate: GenreMovieCellDelegate?
    
    private let tapActionID = UIAction.Identifier("genre.tap")
    
    lazy var genreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.appBlue, for: .normal)
        button.backgroundColor = .appGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return button
    }()
    
        func configureGenreCell(id: Int, title: String) {
            genreButton.setTitle(title, for: .normal)
            
            // Снимаем старый action (переиспользование ячеек)
            genreButton.removeAction(identifiedBy: tapActionID, for: .touchUpInside)
            
            let action = UIAction(identifier: tapActionID) { [weak self] _ in
                self?.delegate?.didTapGenre(id: id, title: title)
            }
            genreButton.addAction(action, for: .touchUpInside)
        }
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
