//
//  TMDBAttributionCell.swift
//  MovieApp
//
//  Created by VladOS on 05.12.2025.
//

import UIKit

final class TMDBAttributionCell: UICollectionViewCell {
    static let reuseId = "TMDBAttributionCell"

    private let stack: UIStackView = {
        let logo = UIImageView(image: UIImage(named: "tmdbLogo"))
        logo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logo.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = "Data provided by TMDB"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .appGray

        let stack = UIStackView(arrangedSubviews: [logo, label])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
