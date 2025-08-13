//
//  MainSectionHeaderView.swift
//  MovieApp
//
//  Created by VladOS on 13.08.2025.
//

import UIKit

protocol MainSectionHeaderViewProtocol: AnyObject {
    
}

class MainSectionHeaderView: UICollectionReusableView {
    
    static let reuseId = "MainSectionHeaderView"
    
    private lazy var headerLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .appWhite
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
    }
    
    func setHeaderView(with title: String) {
        headerLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
