//
//  PosterCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    static let reuseId = "PosterCell"
    
    private lazy var posterView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private lazy var posterLabel: UILabel = CellLabel(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: .appWhite)
    
    private lazy var playButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.setBackgroundImage(.playBtn, for: .normal)
        $0.backgroundColor = .appBlue.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 20
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterView)
        contentView.addSubview(playButton)
        contentView.addSubview(posterLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1),
            
            playButton.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: posterView.centerYAnchor),
            
            posterLabel.bottomAnchor.constraint(equalTo: posterView.bottomAnchor, constant: -16),
            posterLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 16),
            posterLabel.trailingAnchor.constraint(lessThanOrEqualTo: posterView.trailingAnchor, constant: -16)
        ])
    }
    
    func configurePosterCell(with movieVM: MovieCellViewModel) {
        posterView.image = movieVM.posterImage
        posterLabel.text = movieVM.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
