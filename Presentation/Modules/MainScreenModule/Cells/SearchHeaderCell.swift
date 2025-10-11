//
//  SearchHeaderCell.swift
//  MovieApp
//
//  Created by VladOS on 09.10.2025.
//

import UIKit

final class SearchHeaderCell: UICollectionViewCell {
    static let reuseId = "SearchHeaderCell"
    
    var onSearchTapped: (() -> Void)?
    var onSettingsTapped: (() -> Void)?
    
    private lazy var searchButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .appWhite
        $0.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var settingsButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "gearshape"), for: .normal)
        $0.tintColor = .appWhite
        $0.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Search movies..."
        $0.textColor = .appWhite
        $0.backgroundColor = .appGray.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 10
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        $0.leftViewMode = .always
        return $0
    }(UITextField())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(searchButton)
        contentView.addSubview(settingsButton)
        contentView.addSubview(textField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            settingsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            
            textField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc private func searchTapped() {
        onSearchTapped?()
    }
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
