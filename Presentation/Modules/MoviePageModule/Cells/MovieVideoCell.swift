//
//  MovieVideoCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

protocol MovieVideoCellDelegate: AnyObject {
    func didTapPlayButton(in cell: MovieVideoCell)
}

class MovieVideoCell: UICollectionViewCell {
    static let reuseId = "MovieTrailerCell"
    
    weak var delegate: MovieVideoCellDelegate?
    
    private lazy var videoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var videoSite: UILabel = CellLabel(font: .systemFont(ofSize: 12, weight: .bold), color: .appRed)
    private lazy var videoName: UILabel = CellLabel(font: .systemFont(ofSize: 12, weight: .bold), color: .appWhite)
    private lazy var videoType: UILabel = CellLabel(font: .systemFont(ofSize: 12, weight: .bold), color: .appGray)
    
    private lazy var videoStackLabel: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [videoSite, videoName, videoType]))
    
    private lazy var playTrailerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func didTapPlay() {
        delegate?.didTapPlayButton(in: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(videoImage)
        contentView.addSubview(videoStackLabel)
        contentView.addSubview(playTrailerButton)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            videoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            videoImage.heightAnchor.constraint(equalToConstant: 100),
            
            playTrailerButton.centerXAnchor.constraint(equalTo: videoImage.centerXAnchor),
            playTrailerButton.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor),
            
            videoStackLabel.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor),
            videoStackLabel.leadingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: 20),
        ])
    }
    
    func configureMovieVideoCell(with videoVM: VideoCellViewModel) {
        videoImage.image = videoVM.thumbnailImage
        videoSite.text = videoVM.site
        videoName.text = videoVM.name
        videoType.text = videoVM.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
