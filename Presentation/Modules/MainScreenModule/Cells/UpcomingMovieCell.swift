//
//  UpcomingMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 10.08.2025.
//

import UIKit

final class UpcomingMovieCell: UICollectionViewCell {
    static let reuseId = "UpcomingMovieCell"
    
    private lazy var imageUpcomingView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var titleLabel: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .bold), color: .white)

    private lazy var releaseDate: UILabel = {
        let label = PaddingLabel(withInsets: 5, 5, 5, 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .systemBlue
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageUpcomingView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDate)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageUpcomingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageUpcomingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageUpcomingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageUpcomingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            releaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            releaseDate.bottomAnchor.constraint(equalTo: imageUpcomingView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureUpcomingCell(with movieVM: MovieCellViewModel) {
        imageUpcomingView.image = movieVM.posterImage
        titleLabel.text = movieVM.title
        releaseDate.text = movieVM.releaseDateText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
