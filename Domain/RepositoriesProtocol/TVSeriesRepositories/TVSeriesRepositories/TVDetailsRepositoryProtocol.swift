//
//  TVSeriesDetailsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

protocol TVDetailsRepositoryProtocol: AnyObject {
    
    func fetchTopRatedTVSeries(page: Int) async throws -> [TVDetails]
    
    func fetchPopularTVSeries(page: Int) async throws -> [TVDetails]
        
    func fetchTVSeriesDetails(byId id: Int) async throws -> TVDetails
}
