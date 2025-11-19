//
//  SettingsCell.swift
//  MovieApp
//
//  Created by VladOS on 15.10.2025.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let reuseId = "SettingsCell"
    
    var completion: (() -> ())?
    
    private lazy var cellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .appGray.withAlphaComponent(0.5)
        $0.addSubview(stackSetting)
        return $0
    }(UIView())
    
     private lazy var stackSetting: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(labelCell)
        return $0
    }(UIStackView())
    
    private lazy var labelCell = TextLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .appWhite.withAlphaComponent(0.5))
    
    private lazy var changedButton: UIButton = {
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .systemBlue
        return $0
    }(UIButton(primaryAction: changedButtonAction))
    
    private lazy var changedButtonAction = UIAction { [weak self] _ in
        self?.completion?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellView)
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackSetting.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            stackSetting.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15),
            stackSetting.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            stackSetting.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
        ])
    }
    
    func configureSettingsCell(cellType: SettingItems) {
        switch cellType {
        case .changePassword, .deletePassword:
            stackSetting.addArrangedSubview(changedButton)
        }
        
        labelCell.text = cellType.rawValue
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
