//
//  OverviewCell.swift
//  MovieApp
//
//  Created by VladOS on 30.08.2025.
//

import UIKit

protocol OverviewCellDelegate: AnyObject {
    func overviewCellDidToggle(_ cell: OverviewCell)
}

class OverviewCell: UICollectionViewCell {
    static let reuseId = "OverviewCell"
    
    weak var delegate: OverviewCellDelegate?
    
    private lazy var overviewLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .appWhite
        $0.numberOfLines = 3
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return $0
    }(UILabel())

    private lazy var viewMoreButton: UIButton = {
        $0.setTitle("View More", for: .normal)
        $0.setTitleColor(.appBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        $0.addTarget(self, action: #selector(didTapViewMore), for: .touchUpInside)
//        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIButton(type: .system))
    
    private lazy var overviewStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .lastBaseline
        return $0
    }(UIStackView(arrangedSubviews: [overviewLabel, viewMoreButton]))
    
    @objc private func didTapViewMore() {
        delegate?.overviewCellDidToggle(self)
    }

    func configureOverviewCell(with detailsText: String, expanded: Bool) {
        overviewLabel.text = detailsText
        // expanded == true -> full height (numberOfLines = 0)
        overviewLabel.numberOfLines = expanded ? 0 : 3
        viewMoreButton.setTitle(expanded ? "View Less" : "View More", for: .normal)
//        overviewLabel.lineBreakMode = .byTruncatingTail
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(overviewStack)
        NSLayoutConstraint.activate([
            overviewStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            overviewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overviewStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewMoreButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor),
            viewMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
