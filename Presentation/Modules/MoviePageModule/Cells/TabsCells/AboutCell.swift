//
//  AboutCell.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import UIKit

class AboutCell: UICollectionViewCell {
    static let reuseId = "AboutCell"

    private lazy var profileImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return $0
    }(UIImageView())
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var characterLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .lightGray
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
//            characterLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    
    func configureAboutCell(with vm: CastCellViewModel) {
        profileImageView.image = vm.profileImage
        nameLabel.text = vm.name
        characterLabel.text = vm.character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
