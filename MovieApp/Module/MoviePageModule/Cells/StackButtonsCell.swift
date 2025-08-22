//
//  StackButtonsCell.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import UIKit

class StackButtonsCell: UICollectionViewCell {
    
    static let reuseId = "StackButtonsCell"
    
    private lazy var buttonsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func configureStackButtonsCell() {
        
    }
    
    private func configureStackButtons() {
        let actions: [(String, Selector)] = [
            ("heartWhite", #selector(didTapHeart)),
            ("favoritesWhite", #selector(didTapFavorite)),
            ("telegram", #selector(didTapShare))
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
    
    @objc private func didTapHeart() { print("Heart tapped") }
    @objc private func didTapFavorite() { print("Favorite tapped") }
    @objc private func didTapShare() { print("Share tapped") }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
