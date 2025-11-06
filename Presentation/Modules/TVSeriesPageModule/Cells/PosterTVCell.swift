//
//  PosterTVCell.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

protocol PosterTVCellDelegate: AnyObject {
    func didTapPlayButton(in cell: PosterTVCell)
}

final class PosterTVCell: UICollectionViewCell {
    static let reuseId = "PosterTVCell"
    
    weak var delegate: PosterTVCellDelegate?

    private lazy var posterView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
        
    private lazy var playTrailerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func didTapPlay() {
        delegate?.didTapPlayButton(in: self)
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterView)
        contentView.addSubview(playTrailerButton)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.5),
            
            playTrailerButton.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
            playTrailerButton.centerYAnchor.constraint(equalTo: posterView.centerYAnchor),
            
        ])
    }
    
    func configureTVPosterCell(with vm: TVDetailsCellViewModel) {
        posterView.image = vm.posterImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

