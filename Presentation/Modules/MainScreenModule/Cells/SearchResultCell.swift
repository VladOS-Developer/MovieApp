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
    
    private lazy var typeLabel: UILabel = {
        let label = PaddingLabel(withInsets: 5, 5, 5, 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .appWhite
        label.backgroundColor = .appGray.withAlphaComponent(0.4)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(resultImage)
        contentView.addSubview(typeLabel)
        setupConstraints()
    }

    func configureResultCell(with viewModel: MovieCellViewModel) {
        resultImage.image = viewModel.posterImage
        typeLabel.text = "Movie"
        typeLabel.isHidden = false
    }
    
    func configureResultCell(with viewModel: TVSeriesCellViewModel) {
        resultImage.image = viewModel.posterImage
        typeLabel.text = "Series"
        typeLabel.isHidden = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            resultImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            resultImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            typeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
