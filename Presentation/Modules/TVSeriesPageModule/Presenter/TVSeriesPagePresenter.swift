//
//  TVSeriesPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVSeriesPagePresenterProtocol: AnyObject {
    
    init(view: TVSeriesPageViewProtocol,
         seriesTitle: String,
         seriesId: Int)
    
    func getTVSeriesData()
}

class TVSeriesPagePresenter: TVSeriesPagePresenterProtocol {
  
    private weak var view: TVSeriesPageViewProtocol?
    private let seriesTitle: String
    private var seriesId: Int
    
    required init(view: TVSeriesPageViewProtocol,
                  seriesTitle: String,
                  seriesId: Int) {
        
        self.view = view
        self.seriesId = seriesId
        self.seriesTitle = seriesTitle
    }
    
    func getTVSeriesData() {
        
    }
}
