//
//  TabBarView.swift
//  MovieApp
//
//  Created by VladOS on 06.08.2025.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(controller: [UIViewController])
}

class TabBarView: UITabBarController {
    
    var presenter: TabBarPresenterProtocol!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarView: TabBarViewProtocol {
    
    func setControllers(controller: [UIViewController]) {
        
    }
    
}
