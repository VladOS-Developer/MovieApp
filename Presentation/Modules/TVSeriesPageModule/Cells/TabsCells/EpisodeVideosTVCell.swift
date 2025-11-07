//
//  EpisodeVideosTVCell.swift
//  MovieApp
//
//  Created by VladOS on 07.11.2025.
//

import UIKit

protocol EpisodeVideoTVCellDelegate: AnyObject {
    func didTapPlayButton(in cell: EpisodeVideoTVCell)
}

final class EpisodeVideoTVCell: UICollectionViewCell {
    static let reuseId = "EpisodeVideoTVCell"
    
    weak var delegate: EpisodeVideoTVCellDelegate?
    
    private lazy var videoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        return $0
    }(UIImageView())
    
    private lazy var videoSiteLabel: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .bold),color: .appRed)
    private lazy var videoNameLabel: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .bold),color: .appWhite)
    private lazy var videoTypeLabel: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .bold),color: .appGray)
    
    private lazy var labelsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [videoSiteLabel, videoNameLabel, videoTypeLabel]))
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapPlay() {
        delegate?.didTapPlayButton(in: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(videoImageView)
        contentView.addSubview(labelsStack)
        contentView.addSubview(playButton)
        videoNameLabel.lineBreakMode = .byTruncatingTail
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            videoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            playButton.centerXAnchor.constraint(equalTo: videoImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: videoImageView.centerYAnchor),
            
            labelsStack.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 10),
            labelsStack.centerYAnchor.constraint(equalTo: videoImageView.centerYAnchor),
            labelsStack.widthAnchor.constraint(lessThanOrEqualToConstant: 170),
            labelsStack.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
    }
    
    func configureEpisodeVM(with videoVM: TVEpisodeVideoCellViewModel) {
        videoImageView.image = videoVM.thumbnailImage
        videoSiteLabel.text = videoVM.site
        videoNameLabel.text = videoVM.name
        videoTypeLabel.text = videoVM.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


