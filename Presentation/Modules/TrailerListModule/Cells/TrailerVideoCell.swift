//
//  TrailerVideoCell.swift
//  MovieApp
//
//  Created by VladOS on 30.09.2025.
//

import UIKit

protocol TrailerVideoCellDelegate: AnyObject {
    func didTapTrailerListButton(in cell: TrailerVideoCell)
}

class TrailerVideoCell: UITableViewCell {
    static let reuseId = "TrailerVideoCell"
    
    weak var delegate: TrailerVideoCellDelegate?
    
    private lazy var videoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
        $0.widthAnchor.constraint(equalToConstant: 200).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var playTrailerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func didTapPlay() {
        delegate?.didTapTrailerListButton(in: self)
    }
    
    private lazy var imageContainer: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(videoImage)
        $0.addSubview(playTrailerButton)
        return $0
    }(UIView())
    
    private lazy var videoSite: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .bold), color: .appRed)
    private lazy var videoName: UILabel = TextLabel(font: .systemFont(ofSize: 14, weight: .semibold), color: .appWhite)
    private lazy var videoType: UILabel = TextLabel(font: .systemFont(ofSize: 12, weight: .regular), color: .appGray)
    
    private lazy var infoStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        return $0
    }(UIStackView(arrangedSubviews: [videoSite, videoName, videoType]))
    
    private lazy var containerStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 12
        return $0
    }(UIStackView(arrangedSubviews: [imageContainer, infoStack]))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerStack)
        backgroundColor = .clear
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            videoImage.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            videoImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            
            playTrailerButton.centerXAnchor.constraint(equalTo: videoImage.centerXAnchor),
            playTrailerButton.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor)
        ])
    }
    
    func configureTrailerMovieVideoCell(with videoVM: TrailerVideoCellViewModel) {
        videoImage.image = videoVM.thumbnailImage
        videoSite.text = videoVM.site
        videoName.text = videoVM.name
        videoType.text = videoVM.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
