//
//  SpecificationTVCell.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

final class SpecificationTVCell: UICollectionViewCell {
    static let reuseId = "SpecificationTVCell"
    
    private lazy var starImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "star")
        $0.tintColor = .appBlue
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private lazy var voteAverageLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .appBlue)
    private lazy var dotOne: UILabel = makeDot()
    private lazy var runtimeLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appWhite)
    private lazy var dotTwo: UILabel = makeDot()
    private lazy var genreLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appWhite)
    
    private func makeDot() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "•"
        label.textColor = .appWhite
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }
    
    private lazy var genreBorderLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)
    private lazy var releaseDateBorderLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)
    private lazy var countryBorderLabel: UILabel = TextLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)

    private func makeBorderView(with label: UILabel) -> UIView {
        let container = UIView()
        container.layer.borderColor = UIColor.appBlue.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
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
    
    private lazy var genreForView: UIView = makeBorderView(with: genreBorderLabel)
    private lazy var releaseDateForView: UIView = makeBorderView(with: releaseDateBorderLabel)
    private lazy var countryForView: UIView = makeBorderView(with: countryBorderLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [starImageView, voteAverageLabel, dotOne, runtimeLabel, dotTwo, genreLabel].forEach {
            contentView.addSubview($0)
        }
     
        [genreForView, releaseDateForView, countryForView].forEach {
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            starImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            
            voteAverageLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 7),
            voteAverageLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            dotOne.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 7),
            dotOne.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            runtimeLabel.leadingAnchor.constraint(equalTo: dotOne.trailingAnchor, constant: 7),
            runtimeLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            dotTwo.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor, constant: 7),
            dotTwo.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            genreLabel.leadingAnchor.constraint(equalTo: dotTwo.trailingAnchor, constant: 7),
            genreLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            genreLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            genreForView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 7),
            genreForView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            releaseDateForView.leadingAnchor.constraint(equalTo: genreForView.trailingAnchor, constant: 7),
            releaseDateForView.centerYAnchor.constraint(equalTo: genreForView.centerYAnchor),
            
            countryForView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryForView.topAnchor.constraint(equalTo: genreForView.bottomAnchor, constant: 7),
            
        ])
    }
    
    func configureTVSpecificationCell(with detailsVM: TVDetailsCellViewModel) {
        voteAverageLabel.text = detailsVM.ratingText
        runtimeLabel.text = detailsVM.runtimeText
        genreLabel.text = detailsVM.genresText
        
        genreBorderLabel.text = detailsVM.genresText
        releaseDateBorderLabel.text = detailsVM.releaseDateText
        countryBorderLabel.text = detailsVM.countryText
                
        let value = detailsVM.ratingValue ?? 0
        if value >= 8.0 {
            starImageView.image = UIImage(systemName: "star.fill")
        } else if value >= 4.0 {
            starImageView.image = UIImage(systemName: "star.leadinghalf.fill")
        } else {
            starImageView.image = UIImage(systemName: "star")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

