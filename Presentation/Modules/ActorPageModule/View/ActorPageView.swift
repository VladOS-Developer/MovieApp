//
//  ActorPageView.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

protocol ActorPageViewProtocol: AnyObject {
    func setTitle(_ text: String)
}

class ActorPageView: UIViewController {
    
    var presenter: ActorPagePresenterProtocol!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarWithBackButton(title: title, backAction: #selector(didTapBack))
        presenter.viewDidLoad()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension ActorPageView: ActorPageViewProtocol {
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
}
