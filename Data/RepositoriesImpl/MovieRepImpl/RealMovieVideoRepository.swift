//
//  RealMovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 10.09.2025.
//

import Foundation

final class RealMovieVideoRepository: MovieVideoRepositoryProtocol {
    
    func fetchMovieVideo(for movieId: Int, completion: @escaping ([MovieVideo]) -> Void) {
        // TODO: Реализовать запрос к TMDB API
        // Пример:
        // networkClient.request(endpoint: "/movie/\(movieId)/videos") { (result: Result<[MovieVideoDTO], Error>) in
        //     switch result {
        //     case .success(let dtos):
        //         completion(dtos.map { MovieVideo(dto: $0) })
        //     case .failure:
        //         completion([])
        //     }
        // }
        completion([]) // пока пусто
    }
}
