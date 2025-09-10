//
//  MockMovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieVideoRepository: MovieVideoRepositoryProtocol {
    static let shared = MockMovieVideoRepository()
    private init() {}
    
//    func fetchMovieVideo(for movieId: Int) -> [MovieVideo] {
//        MovieVideo.mockMovieVideo()
//    }
    func fetchMovieVideo(for movieId: Int, completion: @escaping ([MovieVideo]) -> Void) {
            completion(MovieVideo.mockMovieVideo())
        }
}
