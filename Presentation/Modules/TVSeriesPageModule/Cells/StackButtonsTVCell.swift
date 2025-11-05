//
//  StackButtonsTVCell.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

class StackButtonsTVCell: UICollectionViewCell {
    static let reuseId = "StackButtonsTVCell"
    
    private lazy var buttonsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackButtons()
        contentView.addSubview(buttonsStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
 
    private func configureStackButtons() {
        let actions: [(String, Selector)] = [
            ("appTelegram", #selector(didTapTelegram)),
            ("appFacebook", #selector(didTapFacebook)),
            ("appInstagram", #selector(didTapInstagram))
        ]
        
        actions.forEach { (name, selector) in
            let button = UIButton(type: .custom)
            button.setBackgroundImage(UIImage(named: name), for: .normal)
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            buttonsStack.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapTelegram() { print("Telegram tapped") }
    @objc private func didTapFacebook() { print("Facebook tapped") }
    @objc private func didTapInstagram() { print("Instagram tapped") }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

