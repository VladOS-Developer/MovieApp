//
//  MovieVideoCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

class MovieVideoCell: UICollectionViewCell {
    static let reuseId = "MovieTrailerCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(videoImage)
        contentView.addSubview(videoStackLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            videoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            videoImage.heightAnchor.constraint(equalToConstant: 100),
            
            videoStackLabel.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor),
            videoStackLabel.leadingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: 20),
        ])
    }
    
    func configureMovieVideoCell(with movieVM: PageVideoCellViewModel) {
        videoImage.image = movieVM.thumbnailImage
        videoSite.text = movieVM.site
        videoName.text = movieVM.name
        videoType.text = movieVM.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
