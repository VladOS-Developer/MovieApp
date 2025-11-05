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
        self.tvId = tvId
        self.tvTitle = tvTitle
    }
    
    func getTVSeriesData() {
        
    }
}
