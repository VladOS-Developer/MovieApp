//
//  DynamicView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol DynamicViewProtocol: AnyObject {
    
}

class DynamicView: UIViewController {

    var presenter: DynamicPresenterProtocol!
    
////    private lazy var topView: UIView = {
////        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
////        $0.backgroundColor = .clear
////      
////        $0.addSubview(topBackButton)
////        return $0
//        
//    }(UIView())
    private lazy var topBackButton: UIButton = {
        $0.frame = CGRect(x: 35, y: 65, width: 20, height: 20)
        $0.setBackgroundImage(.appArrow, for: .normal)
        return $0
    }(UIButton(primaryAction: backButtonAction))
    
    lazy var backButtonAction = UIAction { [weak self] _ in
        guard let self = self,
              let tabBarVC = self.tabBarController as? TabBarView else { return }
        tabBarVC.selectedIndex = 0
        tabBarVC.setTabBarButtonsHidden(false)
        print("TabBar появился")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topBackButton)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarVC = self.tabBarController as? TabBarView {
            tabBarVC.setTabBarButtonsHidden(true)
            print("TabBar скрылся")
        }
    }
    
}


extension DynamicView: DynamicViewProtocol {
    
}
