//
//  TVSeriesPageView.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVSeriesPageViewProtocol: AnyObject {
    
}

class TVSeriesPageView: UIViewController {
    
    var presenter: TVSeriesPagePresenterProtocol!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarWithBackAndRightButton(title: title,
                                              backAction: #selector(didTapBack),
                                              rightSystemName: "heart",
                                              rightAction: #selector(didTapHeart))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        print("TabBar скрылся")
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        if !(navigationController?.topViewController is ActorPageView) {
            (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
        }
    }
    
    @objc private func didTapHeart() {
        
    }
    
   
    
}

extension TVSeriesPageView: TVSeriesPageViewProtocol {
    
}
