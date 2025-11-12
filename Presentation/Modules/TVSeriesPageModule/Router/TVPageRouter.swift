//
//  TVPageRouter.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVPageRouterProtocol: AnyObject {
    func showTVTrailerPlayer(video: TVVideo, title: String)
    func showTVEpisodeTrailerPlayer(video: TVEpisodeVideo, title: String, tvId: Int)
    func showActorPage(actorName: String, actorId: Int)
    func showTVPage(tvId: Int, tvTitle: String)
}

final class TVPageRouter: TVPageRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showTVTrailerPlayer(video: TVVideo, title: String) {
        let tvTrailerVC = Builder.createTrailerPlayerController(video: video, tvTitle: title)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(tvTrailerVC, animated: true)
        } else {
            viewController?.present(tvTrailerVC, animated: true)
        }
    }
    
    func showTVEpisodeTrailerPlayer(video: TVEpisodeVideo, title: String, tvId: Int) {
        let tvTrailerVC = Builder.createEpisodeTrailerPlayerController(video: video, tvTitle: title, tvId: tvId)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(tvTrailerVC, animated: true)
        } else {
            viewController?.present(tvTrailerVC, animated: true)
        }
    }
    
    func showActorPage(actorName: String, actorId: Int) {
        let actorPageVC = Builder.createActorPageController(actorTitle: actorName, actorId: actorId)
        viewController?.navigationController?.pushViewController(actorPageVC, animated: true)
    }
    
    func showTVPage(tvId: Int, tvTitle: String) {
        let tvPageVC = Builder.createTVSeriesController(id: tvId, title: tvTitle)
        viewController?.navigationController?.pushViewController(tvPageVC, animated: true)
    }
    
}
