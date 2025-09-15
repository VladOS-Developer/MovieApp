//
//  ActorPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

protocol ActorPagePresenterProtocol: AnyObject {
    init(view: ActorPageViewProtocol,
         actorTitle: String)
    
    func viewDidLoad()
}

class ActorPagePresenter: ActorPagePresenterProtocol {
    
    private weak var view: ActorPageViewProtocol?
    private let actorTitle: String
    
    required init(view: ActorPageViewProtocol, actorTitle: String) {
        self.view = view
        self.actorTitle = actorTitle
    }
    
    func viewDidLoad() {
        view?.setTitle(actorTitle)
    }
    
}
