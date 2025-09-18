//
//  ActorFilmographyCell.swift
//  MovieApp
//
//  Created by VladOS on 18.09.2025.
//

import UIKit

final class ActorFilmographyCell: UICollectionViewCell {
    static let reuseId = "ActorFilmographyCell"
        
    private lazy var actorMovie: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorMovie)

        NSLayoutConstraint.activate([
            actorMovie.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            actorMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            actorMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            actorMovie.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)

        ])
    }
    
    func configureFilmographyMovieCell(with movieVM: ActorMovieCellViewModel) {
        actorMovie.image = movieVM.posterImage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
