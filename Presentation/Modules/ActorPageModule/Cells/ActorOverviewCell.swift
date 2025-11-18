//
//  ActorBiographyCell.swift
//  MovieApp
//
//  Created by VladOS on 18.09.2025.
//

import UIKit

protocol ActorOverviewCellDelegate: AnyObject {
    func actorOverviewCellDidToggle(_ cell: ActorOverviewCell)
}

class ActorOverviewCell: UICollectionViewCell {
    static let reuseId = "ActorOverviewCell"
    
    weak var delegate: ActorOverviewCellDelegate?
    
    private lazy var actorOverviewLabel: UILabel = {
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
        return $0
    }(UIButton(type: .system))
    
    private lazy var overviewStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .lastBaseline
        return $0
    }(UIStackView(arrangedSubviews: [actorOverviewLabel, viewMoreButton]))
    
    @objc private func didTapViewMore() {
        delegate?.actorOverviewCellDidToggle(self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(overviewStack)
        NSLayoutConstraint.activate([
            overviewStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            overviewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overviewStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            viewMoreButton.topAnchor.constraint(equalTo: actorOverviewLabel.bottomAnchor, constant: 0),
            viewMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func configureActorOverviewCell(with detailsText: String, expanded: Bool) {
        actorOverviewLabel.text = detailsText
        actorOverviewLabel.numberOfLines = expanded ? 0 : 3
        viewMoreButton.setTitle(expanded ? "View Less" : "View More", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
