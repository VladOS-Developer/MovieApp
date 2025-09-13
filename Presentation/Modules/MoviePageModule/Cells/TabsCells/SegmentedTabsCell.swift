//
//  SegmentedTabsCell.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import UIKit

final class SegmentedTabsCell: UICollectionViewCell {
    static let reuseId = "TabsCell"

    var onTabSelected: ((Int) -> Void)?

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["More Like This", "About", "Comments"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = UISegmentedControl.noSegment
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
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

    @objc private func tabChanged() {
        onTabSelected?(segmentedControl.selectedSegmentIndex)
    }

//    func configureSegmentedTabsCell(selectedIndex: Int) {
//        segmentedControl.selectedSegmentIndex = selectedIndex
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
