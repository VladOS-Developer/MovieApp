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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(resultImage)
        setupConstraints()
    }

    func configureResultCell(with viewModel: MovieCellViewModel) {
        resultImage.image = viewModel.posterImage
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            resultImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            resultImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
