//
//  MovieVideoRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol MovieVideoRepositoryProtocol: AnyObject {
//    func fetchMovieVideo(for movieId: Int) -> [MovieVideo]
    func fetchMovieVideo(for movieId: Int, completion: @escaping ([MovieVideo]) -> Void)
}
