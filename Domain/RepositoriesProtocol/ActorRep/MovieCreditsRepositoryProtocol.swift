//
//  MovieCreditsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

protocol MovieCreditsRepositoryProtocol: AnyObject {
    func fetchCredits(for movieId: Int) -> MovieCredits
}
