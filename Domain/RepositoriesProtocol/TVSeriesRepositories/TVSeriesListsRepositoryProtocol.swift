//
//  TVSeriesListsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

protocol TVSeriesListsRepositoryProtocol: AnyObject {
    
    func fetchTVSeriesLists() async throws -> [TVSeriesLists]
}
