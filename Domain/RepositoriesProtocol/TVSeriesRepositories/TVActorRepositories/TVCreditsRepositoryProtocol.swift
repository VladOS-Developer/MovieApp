//
//  TVCreditsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

protocol TVCreditsRepositoryProtocol: AnyObject {
    
    func fetchCredits(for tvId: Int) async throws -> TVCredits
}
