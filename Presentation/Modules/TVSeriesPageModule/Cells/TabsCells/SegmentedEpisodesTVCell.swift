//
//  SegmentedEpisodesTVCell.swift
//  MovieApp
//
//  Created by VladOS on 07.11.2025.
//

import UIKit

protocol SegmentedEpisodesTVCellDelegate: AnyObject {
    func didSelectSeason(index: Int)
}

final class SegmentedEpisodesTVCell: UICollectionViewCell {
    static let reuseId = "SegmentedEpisodesTVCell"
    
    weak var delegate: SegmentedEpisodesTVCellDelegate?
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Season 1", "Season 2", "Season 3"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
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
    
    @objc private func didChangeSegment() {
        delegate?.didSelectSeason(index: segmentedControl.selectedSegmentIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
