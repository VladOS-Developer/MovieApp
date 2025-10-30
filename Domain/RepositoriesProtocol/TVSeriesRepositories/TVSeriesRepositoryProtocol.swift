//
//  TVSeriesRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

protocol TVSeriesRepositoryProtocol: AnyObject {
    
    func fetchTVSeriesLists() async throws -> [TVSeries]
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries]
}
