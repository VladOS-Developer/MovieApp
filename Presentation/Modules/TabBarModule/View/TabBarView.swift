//
//  TabBarView.swift
//  MovieApp
//
//  Created by VladOS on 06.08.2025.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(controllers: [UIViewController])
}

final class TabBarView: UITabBarController {
    
    var presenter: TabBarPresenterProtocol!
    
    private var tabBarButtons: [UIButton] = []
    private let tabsIcon: [UIImage] = [.appHome, .appYoutube, .appFavorite]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
        LayoutTabBarButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        view.backgroundColor = .clear
        
        tabsIcon.enumerated().forEach {
            let tabBarButton = createTabBarButton(icon: $0.element, tag: $0.offset)
            tabBarButtons.append(tabBarButton)
            view.addSubview(tabBarButton)
        }
    }
    
    func setTabBarButtonsHidden(_ hidden: Bool) {
        tabBarButtons.forEach { $0.isHidden = hidden }
    }
    
    lazy var hendleTabSelection = UIAction { [weak self] sender in
        guard let self = self,
              let sender = sender.sender as? UIButton else { return }
        self.selectedIndex = sender.tag
    }
    
    private func createTabBarButton(icon: UIImage, tag: Int) -> UIButton {
        return {
            let btnSize: CGFloat = 30
            $0.frame.size = CGSize(width: btnSize, height: btnSize)
            $0.setBackgroundImage(icon, for: .normal)
            $0.tag = tag
            $0.tintColor = .appWhite
            return $0
        }(UIButton(primaryAction: hendleTabSelection))
    }
    
    private func LayoutTabBarButtons() {
        let btnSize: CGFloat = 35
        let totalWidth = view.bounds.width
        let spacing = totalWidth / CGFloat(tabBarButtons.count + 1)
        let yPosition = view.bounds.height - btnSize - 40
        
        for (index, button) in tabBarButtons.enumerated() {
            let x = spacing * CGFloat(index + 1)
            button.frame = CGRect(x: 0, y: yPosition, width: btnSize, height: btnSize)
            button.center.x = x
        }
    }
    
}

extension TabBarView: TabBarViewProtocol {
    
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
    
}
