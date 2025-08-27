//
//  SpecificationCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

final class SpecificationCell: UICollectionViewCell {
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
    
    private lazy var genreBorderLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)
    private lazy var releaseDateBorderLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)
    private lazy var countryBorderLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .appBlue)

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
    
    private lazy var overviewLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .appWhite
        $0.numberOfLines = 3
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return $0
    }(UILabel())

    private lazy var viewMoreButton: UIButton = {
        $0.setTitle("View More", for: .normal)
        $0.setTitleColor(.appBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        $0.addTarget(self, action: #selector(didTapViewMore), for: .touchUpInside)
//        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIButton(type: .system))
    
    private lazy var overviewStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .lastBaseline
        $0.spacing = 4
        return $0
    }(UIStackView(arrangedSubviews: [overviewLabel, viewMoreButton]))
    
    @objc private func didTapViewMore() {
        if overviewLabel.numberOfLines == 0 {
            overviewLabel.numberOfLines = 3
            viewMoreButton.setTitle("View More", for: .normal)
        } else {
            overviewLabel.numberOfLines = 0
            viewMoreButton.setTitle("View Less", for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [starImageView, voteAverageLabel, dotOne, runtimeLabel, dotTwo, genreLabel].forEach {
            contentView.addSubview($0)
        }
     
        [genreForView, releaseDateForView, countryForView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.addSubview(overviewStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            starImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
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
            
            genreForView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            genreForView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            releaseDateForView.leadingAnchor.constraint(equalTo: genreForView.trailingAnchor, constant: 7),
            releaseDateForView.centerYAnchor.constraint(equalTo: genreForView.centerYAnchor),
            
            countryForView.leadingAnchor.constraint(equalTo: releaseDateForView.trailingAnchor, constant: 7),
            countryForView.centerYAnchor.constraint(equalTo: genreForView.centerYAnchor),
            
            overviewStack.topAnchor.constraint(equalTo: genreForView.bottomAnchor, constant: 10),
            overviewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            viewMoreButton.bottomAnchor.constraint(equalTo: overviewStack.bottomAnchor)
        ])
    }
    
    func configureSpecificationCell(with movieVM: MovieCellViewModel) {
        voteAverageLabel.text = movieVM.ratingText
        runtimeLabel.text = movieVM.runtimeText
        genreLabel.text = movieVM.genresText
        
        genreBorderLabel.text = movieVM.genresText
        releaseDateBorderLabel.text = movieVM.releaseDateText
        countryBorderLabel.text = movieVM.countryText
        
        overviewLabel.text = movieVM.overview
        
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
