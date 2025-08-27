//
//  TrailerRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol TrailerRepositoryProtocol: AnyObject {
    func fetchTrailer(for movieId: Int) -> [Trailer]
}
