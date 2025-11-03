//
//  TVVideoRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

protocol TVVideoRepositoryProtocol: AnyObject {
    
    func fetchTVVideos(for tvId: Int) async throws -> [TVVideo]
    
}
