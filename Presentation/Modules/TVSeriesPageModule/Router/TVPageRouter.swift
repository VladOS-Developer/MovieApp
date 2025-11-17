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
    
    func openTelegram(text: String)
    func openTwitter(text: String)
    func openShareSheet(text: String)
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
    
    func openTelegram(text: String) {
        let encoded = text.urlEncoded
        let tgURL = URL(string: "tg://msg?text=\(encoded)")!
        
        if UIApplication.shared.canOpenURL(tgURL) {
            UIApplication.shared.open(tgURL)
        } else {
            UIApplication.shared.open(URL(string: "https://t.me")!)
        }
    }
    
    func openTwitter(text: String) {
        let encoded = text.urlEncoded
        let twitterURL = URL(string: "twitter://post?message=\(encoded)")!
        
        if UIApplication.shared.canOpenURL(twitterURL) {
            UIApplication.shared.open(twitterURL)
        } else {
            UIApplication.shared.open(URL(string: "https://twitter.com/intent/tweet?text=\(encoded)")!)
        }
    }
    
    func openShareSheet(text: String) {
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(vc, animated: true)
    }
    
}


