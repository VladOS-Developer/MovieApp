//
//  CastAndCrewHeaderView.swift
//  MovieApp
//
//  Created by VladOS on 14.09.2025.
//

import UIKit

class CastAndCrewHeaderView: UICollectionReusableView {
    static let reuseId = "CastAndCrewHeaderView"
    
    private lazy var headerLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Cast and Crew"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
