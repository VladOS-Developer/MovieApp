//
//  TVSeriesRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

protocol TVSeriesRepositoryProtocol: AnyObject {
    
    func fetchTVSeriesTopRate(page: Int) async throws -> [TVSeries]
    
    func fetchTVSeriesPopular(page: Int) async throws -> [TVSeries]
    
    func fetchTVSeries() async throws -> [TVSeries]
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries]
}
