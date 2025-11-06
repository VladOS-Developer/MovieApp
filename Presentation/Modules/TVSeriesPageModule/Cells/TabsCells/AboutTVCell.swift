//
//  AboutTVCell.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

protocol AboutTVCellDelegate: AnyObject {
    func aboutTVCellDidTapProfileImage(_ cell: AboutTVCell)
}

class AboutTVCell: UICollectionViewCell {
    static let reuseId = "AboutTVCell"
    
    weak var delegate: AboutTVCellDelegate?

    private lazy var profileImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appWhite.withAlphaComponent(0.4).cgColor
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
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            characterLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapProfileImage() {
        delegate?.aboutTVCellDidTapProfileImage(self)
    }
    
    func configureTVAboutCell(with vm: TVCastCellViewModel) {
        profileImageView.image = vm.profileImage
        nameLabel.text = vm.name
        characterLabel.text = vm.character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
