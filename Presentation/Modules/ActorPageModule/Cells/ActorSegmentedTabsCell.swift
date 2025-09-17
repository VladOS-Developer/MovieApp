//
//  ActorSegmentedTabsCell.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import UIKit

final class ActorSegmentedTabsCell: UICollectionViewCell {
    static let reuseId = "ActorSegmentedTabsCell"

    var onActorTabSelected: ((Int) -> Void)?

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Filmography", "Biography"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = UISegmentedControl.noSegment
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.addTarget(self, action: #selector(actorTabChanged), for: .valueChanged)
        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func actorTabChanged() {
        onActorTabSelected?(segmentedControl.selectedSegmentIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
