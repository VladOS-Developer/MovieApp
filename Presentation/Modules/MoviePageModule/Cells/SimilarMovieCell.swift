//
//  SimilarMovieCell.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import UIKit

//protocol SimilarMovieCellDelegate: AnyObject {
//    func didSelectSimilarMovie(_ movieId: Int)
//}

final class SimilarMovieCell: UICollectionViewCell {
    static let reuseId = "SimilarMovieCell"
    
//    weak var delegate: SimilarMovieCellDelegate?
    private var movieId: Int?
//    
    private lazy var similarImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        return $0
    }(UIImageView())

    private lazy var similarTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .white
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(similarImage)
        contentView.addSubview(similarTitle)

        NSLayoutConstraint.activate([
            similarImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            similarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            similarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            similarImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            similarTitle.topAnchor.constraint(equalTo: similarImage.topAnchor, constant: 10),
            similarTitle.leadingAnchor.constraint(equalTo: similarImage.leadingAnchor, constant: 10),
            similarTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            similarTitle.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configureSimilarMovieCell(with similarVM: SimilarMovieCellViewModel) {
//        self.movieId = similarVM.id
        
        similarTitle.text = similarVM.title
        
        if let image = similarVM.posterImage {
            similarImage.image = image
        } else {
            similarImage.image = nil
            // если будет URL — тут вставить загрузку с кешем
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
