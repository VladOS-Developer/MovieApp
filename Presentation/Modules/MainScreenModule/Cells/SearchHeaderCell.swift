//
//  SearchHeaderCell.swift
//  MovieApp
//
//  Created by VladOS on 09.10.2025.
//

import UIKit

final class SearchHeaderCell: UICollectionViewCell, UITextFieldDelegate {
    static let reuseId = "SearchHeaderCell"
    
    var onTextChanged: ((String) -> ())?
    var onCancelTapped: (() -> ())?
    var onSettingsTapped: (() -> ())?
    
    private lazy var cancelButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.appCancel, for: .normal)
        $0.tintColor = .appBlue
        $0.addTarget(self, action: #selector(сancelTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var settingsButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "gearshape"), for: .normal)
        $0.tintColor = .appBlue
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
        $0.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return $0
    }(UITextField())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cancelButton)
        contentView.addSubview(settingsButton)
        contentView.addSubview(textField)
        textField.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 22),
            cancelButton.heightAnchor.constraint(equalToConstant: 22),
            
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            
            textField.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -10),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc private func textDidChange() {
        onTextChanged?(textField.text ?? "")
    }
    
    @objc private func сancelTapped() {
        textField.text = ""
        onTextChanged?("")
        onCancelTapped?()
    }
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
