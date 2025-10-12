//
//  SearchResultCell.swift
//  MovieApp
//
//  Created by VladOS on 12.10.2025.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    static let reuseId = "SearchResultCell"

    private lazy var resultImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var resultLabel: UILabel = TextLabel(font: .systemFont(ofSize: 10, weight: .bold), color: .appWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }


    func configure(with viewModel: MovieCellViewModel) {
        resultLabel.text = viewModel.title
        resultImage.image = viewModel.posterImage
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            resultImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            resultImage.heightAnchor.constraint(equalToConstant: 150),
            
            resultLabel.topAnchor.constraint(equalTo: resultImage.bottomAnchor, constant: 5),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            resultLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
