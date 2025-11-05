//
//  TVSeriesPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVSeriesPagePresenterProtocol: AnyObject {
    
    init(view: TVSeriesPageViewProtocol,
         router: TVSeriesPageRouterProtocol,
         imageLoader: ImageLoaderProtocol,
         
         tvDetailsRepository: TVDetailsRepositoryProtocol,
         tvGenreRepository: TVGenresRepositoryProtocol,
         tvVideoRepository: TVVideoRepositoryProtocol,
         tvSimilarRepository: TVSimilarRepositoryProtocol,
         tvCreditsRepository: TVCreditsRepositoryProtocol,
         
         tvTitle: String,
         tvId: Int)
    
    func getTVSeriesData()
}

class TVSeriesPagePresenter: TVSeriesPagePresenterProtocol {
  
    private weak var view: TVSeriesPageViewProtocol?
    private let router: TVSeriesPageRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let tvDetailsRepository: TVDetailsRepositoryProtocol
    private let tvGenreRepository: TVGenresRepositoryProtocol
    private let tvVideoRepository: TVVideoRepositoryProtocol
    private let tvSimilarRepository: TVSimilarRepositoryProtocol
    private let tvCreditsRepository: TVCreditsRepositoryProtocol
    
    private let tvTitle: String
    private var tvId: Int
    
    private var videos: [TVVideo] = []
    private var sections: [TVPageCollectionSection] = []
    private let favoritesStorage = FavoritesStorage()
    private let currentTVMovie: TVDetails?
    
    required init(view: TVSeriesPageViewProtocol,
                  router: TVSeriesPageRouterProtocol,
                  imageLoader: ImageLoaderProtocol,
                  
                  tvDetailsRepository: TVDetailsRepositoryProtocol,
                  tvGenreRepository: TVGenresRepositoryProtocol,
                  tvVideoRepository: TVVideoRepositoryProtocol,
                  tvSimilarRepository: TVSimilarRepositoryProtocol,
                  tvCreditsRepository: TVCreditsRepositoryProtocol,
                  
                  tvTitle: String,
                  tvId: Int) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        self.tvDetailsRepository = tvDetailsRepository
        self.tvGenreRepository = tvGenreRepository
        self.tvVideoRepository = tvVideoRepository
        self.tvSimilarRepository = tvSimilarRepository
        self.tvCreditsRepository = tvCreditsRepository
        self.tvTitle = tvTitle
        self.tvId = tvId
        self.currentTVMovie = nil //
    }
    
    func getTVSeriesData() {
        
    }
}
