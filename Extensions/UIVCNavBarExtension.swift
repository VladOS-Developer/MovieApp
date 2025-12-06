//
//  UIVCNavBarExtension.swift
//  MovieApp
//
//  Created by VladOS on 11.09.2025.
//

import UIKit

extension UIViewController {
    
    func configureNavBarWithBackButton(title: String?, backAction: Selector) {
        setupBaseNavBar(title: title)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
            style: .plain,
            target: self,
            action: backAction
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
    }
    
    func configureNavBarWithBackAndRightButton(title: String?,
                                               backAction: Selector,
                                               rightSystemName: String,
                                               rightTint: UIColor = .systemRed,
                                               rightAction: Selector) {
        setupBaseNavBar(title: title)
        
        // back
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
            style: .plain,
            target: self,
            action: backAction
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        
        // right
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: rightSystemName,withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
            style: .plain,
            target: self,
            action: rightAction
        )
        navigationItem.rightBarButtonItem?.tintColor = rightTint
    }
    
    private func setupBaseNavBar(title: String?) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .black)
        ]
        navigationItem.title = title
    }
}
