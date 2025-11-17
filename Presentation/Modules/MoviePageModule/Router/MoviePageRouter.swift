//
//  MoviePageRouter.swift
//  MovieApp
//
//  Created by VladOS on 31.08.2025.
//

import UIKit

protocol MoviePageRouterProtocol: AnyObject {
    func showTrailerPlayer(video: MovieVideo, title: String)
    func showActorPage(actorName: String, actorId: Int)
    func showMoviePage(movieId: Int, movieTitle: String)
    
    func openTelegram(text: String)
    func openTwitter(text: String)
    func openShareSheet(text: String)
}

final class MoviePageRouter: MoviePageRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showTrailerPlayer(video: MovieVideo, title: String) {
        let trailerPlayerVC = Builder.createTrailerPlayerController(video: video, movieTitle: title)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(trailerPlayerVC, animated: true)
        } else {
            viewController?.present(trailerPlayerVC, animated: true)
        }
    }
    
    func showActorPage(actorName: String, actorId: Int) {
        let actorPageVC = Builder.createActorPageController(actorTitle: actorName, actorId: actorId)
        viewController?.navigationController?.pushViewController(actorPageVC, animated: true)
    }
    
    func showMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(id: movieId,title: movieTitle)
        viewController?.navigationController?.pushViewController(moviePageVC, animated: true)
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

