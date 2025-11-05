//
//  TVSeriesPageRouter.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVSeriesPageRouterProtocol: AnyObject {
    func showTVTrailerPlayer(video: TVVideo, title: String)
}

final class TVSeriesPageRouter: TVSeriesPageRouterProtocol {
    weak var viewController: UIViewController?
    
    func showTVTrailerPlayer(video: TVVideo, title: String) {
        
        let trailerVC = Builder.createTrailerPlayerController(video: video, tvTitle: title)
        if let nav = viewController?.navigationController {
            nav.pushViewController(trailerVC, animated: true)
        } else {
            viewController?.present(trailerVC, animated: true)
        }
    }
}
