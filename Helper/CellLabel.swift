//
//  CellLabel.swift
//  MovieApp
//
//  Created by VladOS on 12.08.2025.
//

import UIKit

class CellLabel: UILabel {
    
    init(font: UIFont, color: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        self.font = font
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//extension MoviePageView {
//    private func configureNavBar() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.titleTextAttributes = [
//            .foregroundColor: UIColor.appWhite,
//            .font: UIFont.systemFont(ofSize: 20, weight: .black)
//        ]
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
//            style: .plain,
//            target: self,
//            action: #selector(didTapBack))
//        navigationItem.leftBarButtonItem?.tintColor = .appWhite
//    }
//    
//    @objc private func didTapBack() {
//        navigationController?.popViewController(animated: true)
//        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
//    }
//
