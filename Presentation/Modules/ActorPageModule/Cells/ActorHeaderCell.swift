//
//  ActorHeaderCell.swift
//  MovieApp
//
//  Created by VladOS on 16.09.2025.
//

import UIKit

final class ActorHeaderCell: UICollectionViewCell {
    static let reuseId = "ActorHeaderCell"
    
    private lazy var backPoster: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private lazy var dimmingView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.65) // мягкое затемнение
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private lazy var profileImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 65
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return $0
    }(UIImageView())
    
    private lazy var moviesCountLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .lightGray
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var ratingLabel: UILabel = {
        let label = PaddingLabel(withInsets: 5, 5, 5, 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var stackSocials: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 40
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backPoster)
        contentView.addSubview(dimmingView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(moviesCountLabel)
        contentView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            backPoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            backPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backPoster.heightAnchor.constraint(equalTo: backPoster.widthAnchor, multiplier: 0.75),
            
            dimmingView.topAnchor.constraint(equalTo: backPoster.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: backPoster.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: backPoster.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: backPoster.bottomAnchor),
            
            profileImageView.centerXAnchor.constraint(equalTo: backPoster.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: backPoster.centerYAnchor, constant: 15),
            profileImageView.widthAnchor.constraint(equalToConstant: 130),
            profileImageView.heightAnchor.constraint(equalToConstant: 130),
            
            moviesCountLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            moviesCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: moviesCountLabel.bottomAnchor, constant: 5),
            ratingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
        
    }
    
    func configure(with headerVM: ActorHeaderCellViewModel) {
        moviesCountLabel.text = headerVM.moviesCountText  // пока хардкод, потом из VM "66"
        ratingLabel.text = "Rating Top 67" // тоже можно из VM
        profileImageView.image = headerVM.profileImage
        backPoster.image = headerVM.profileImage
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
