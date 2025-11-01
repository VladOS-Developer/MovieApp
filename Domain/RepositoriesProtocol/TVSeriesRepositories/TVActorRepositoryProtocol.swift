//
//  TVActorRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

protocol TVActorRepositoryProtocol: AnyObject {
    
    func fetchActorTVSeries(by id: Int) async throws -> [TVActorMovie]
}
