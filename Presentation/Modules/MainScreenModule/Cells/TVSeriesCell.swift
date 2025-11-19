//
//  TVSeriesCell.swift
//  MovieApp
//
//  Created by VladOS on 29.10.2025.
//

import UIKit

final class TVSeriesCell: UICollectionViewCell {
    static let reuseId = "TVSeriesCell"
    
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
    private lazy var originalTitleLabel: UILabel = TextLabel(font: .systemFont(ofSize: 10, weight: .bold), color: .appGray)
        
    private lazy var stackLabel: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [titleLabel, originalTitleLabel]))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageViewMovie)
        contentView.addSubview(stackLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewMovie.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewMovie.heightAnchor.constraint(equalToConstant: 150),
            
            stackLabel.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 6),
            stackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)

        ])
    }
    
    func configureTVSeriesCell(with seriesVM: TVSeriesCellViewModel) {
        imageViewMovie.image = seriesVM.posterImage
        titleLabel.text = seriesVM.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
