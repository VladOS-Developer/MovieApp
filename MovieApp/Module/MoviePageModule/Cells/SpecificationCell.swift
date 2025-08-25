//
//  SpecificationCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

class SpecificationCell: UICollectionViewCell {
    static let reuseId = "SpecificationCell"
    
    private lazy var starImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "star")
        $0.tintColor = .appBlue
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private lazy var voteAverageLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .appBlue)
    private lazy var dotOne: UILabel = makeDot()
    private lazy var runtimeLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appWhite)
    private lazy var dotTwo: UILabel = makeDot()
    private lazy var genreLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(starImageView)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(dotOne)
        contentView.addSubview(runtimeLabel)
        contentView.addSubview(dotTwo)
        contentView.addSubview(genreLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // star
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            starImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Рейтинг
            voteAverageLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 7),
            voteAverageLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            // •
            dotOne.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 7),
            dotOne.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            // Время
            runtimeLabel.leadingAnchor.constraint(equalTo: dotOne.trailingAnchor, constant: 7),
            runtimeLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            // •
            dotTwo.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor, constant: 7),
            dotTwo.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            // Жанр
            genreLabel.leadingAnchor.constraint(equalTo: dotTwo.trailingAnchor, constant: 7),
            genreLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            genreLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func configureSpecificationCell(with movieVM: MovieCellViewModel) {
        voteAverageLabel.text = movieVM.ratingText
        runtimeLabel.text = movieVM.runtimeText
        genreLabel.text = movieVM.genresText
        
        let value = movieVM.ratingValue ?? 0
        
        if value >= 8.0 {
            starImageView.image = UIImage(systemName: "star.fill")
        } else if value >= 4.0 {
            starImageView.image = UIImage(systemName: "star.leadinghalf.fill")
        } else {
            starImageView.image = UIImage(systemName: "star")
        }
    }
    
    private func makeDot() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "•"
        label.textColor = .appWhite
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
