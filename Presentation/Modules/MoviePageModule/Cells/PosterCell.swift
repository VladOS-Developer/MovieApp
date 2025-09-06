//
//  PosterCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

protocol PosterCellDelegate: AnyObject {
    func didTapPlayButton(in cell: PosterCell)
}

final class PosterCell: UICollectionViewCell {
    static let reuseId = "PosterCell"
    
    weak var delegate: PosterCellDelegate?
    
    private lazy var posterView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private lazy var posterLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: .appWhite)
    
    private lazy var playTrailerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 45).isActive = true
        $0.setBackgroundImage(.playBtn, for: .normal)
        $0.backgroundColor = .appBlue.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 20
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
        contentView.addSubview(posterLabel)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 0.75),
            
            playTrailerButton.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
            playTrailerButton.centerYAnchor.constraint(equalTo: posterView.centerYAnchor),
            
            posterLabel.bottomAnchor.constraint(equalTo: posterView.bottomAnchor, constant: -20),
            posterLabel.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
        ])
    }
    
    func configurePosterCell(with detailsVM: DetailsCellViewModel) {
        posterView.image = detailsVM.posterImage
        posterLabel.text = detailsVM.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
