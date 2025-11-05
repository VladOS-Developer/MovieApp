//
//  SimilarMovieTVCell.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

final class SimilarMovieTVCell: UICollectionViewCell {
    static let reuseId = "SimilarMovieTVCell"

    private lazy var similarImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var voteAverageLabel: UILabel = {
        let label = PaddingLabel(withInsets: 3, 3, 5, 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .appWhite
        label.backgroundColor = .appGray.withAlphaComponent(0.5)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(similarImage)
        contentView.addSubview(voteAverageLabel)

        NSLayoutConstraint.activate([
            similarImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            similarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            similarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            similarImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            voteAverageLabel.topAnchor.constraint(equalTo: similarImage.topAnchor, constant: 10),
            voteAverageLabel.leadingAnchor.constraint(equalTo: similarImage.leadingAnchor, constant: 10)
        ])
    }
    
    func configureSimilarMovieCell(with vm: TVSimilarCellViewModel) {
        voteAverageLabel.text = vm.ratingText
        similarImage.image = vm.posterImage
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

