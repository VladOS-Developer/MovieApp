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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
//        title = "3"
    }
}

extension DynamicView: DynamicViewProtocol {
    
}
