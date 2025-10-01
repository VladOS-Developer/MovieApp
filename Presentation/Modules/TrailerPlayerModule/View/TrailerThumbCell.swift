//
//  TrailerThumbCell.swift
//  MovieApp
//
//  Created by VladOS on 01.10.2025.
//

import UIKit

final class TrailerThumbCell: UICollectionViewCell {
    static let reuseId = "TrailerThumbCell"

    private lazy var thumbnail: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .white
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnail)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 100),

            titleLabel.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    func configure(with vm: TrailerVideoCellViewModel) {
        titleLabel.text = vm.name
        
        if let image = vm.thumbnailImage {
            thumbnail.image = image
        } else if let url = vm.thumbnailURL {
            // простой асинхронный загрузчик, заменить на Kingfisher/SDWebImage в рабочей среде
            thumbnail.image = nil
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data, let img = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    // Проверьте ещё раз, отображается ли тот же URL-адрес? Пропущено для краткости
                    self?.thumbnail.image = img
                }
            }.resume()
        } else {
            thumbnail.image = UIImage(systemName: "film")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
