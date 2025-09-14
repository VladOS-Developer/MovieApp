//
//  MainSectionHeaderView.swift
//  MovieApp
//
//  Created by VladOS on 13.08.2025.
//

import UIKit

protocol MainSectionHeaderViewDelegate: AnyObject {
    func didTapSeeAllButton(in section: Int) //
}

class MainSectionHeaderView: UICollectionReusableView {
    static let reuseId = "MainSectionHeaderView"
    
    weak var delegate: MainSectionHeaderViewDelegate?
    var sectionIndex: Int = 0
    
    private lazy var headerLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 20, weight: .black)
        $0.textColor = .appWhite
        return $0
    }(UILabel())
    
    lazy var seeAllBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.setTitle("See all", for: .normal)
        $0.setTitleColor(.appBlue, for: .normal)
        $0.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc private func seeAllTapped() { //
        delegate?.didTapSeeAllButton(in: sectionIndex)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        addSubview(seeAllBtn)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            seeAllBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    func setHeaderView(with title: String, showsButton: Bool) {
        headerLabel.text = title
        seeAllBtn.isHidden = !showsButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
