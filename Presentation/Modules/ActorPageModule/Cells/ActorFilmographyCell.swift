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
        contentView.addSubview(actorMovie)
        contentView.addSubview(releaseDate)

        NSLayoutConstraint.activate([
            actorMovie.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            actorMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            actorMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            actorMovie.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            releaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            releaseDate.bottomAnchor.constraint(equalTo: actorMovie.bottomAnchor, constant: -10)
        ])
    }
    
    func configureFilmographyMovieCell(with movieVM: ActorMovieCellViewModel) {
        actorMovie.image = movieVM.posterImage
        releaseDate.text = movieVM.releaseDateText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
