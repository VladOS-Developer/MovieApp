//
//  MockMovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieVideoRepository: MovieVideoRepositoryProtocol {
    static let shared = MockMovieVideoRepository()
    
    func fetchMovieVideo(for movieId: Int) async throws -> [MovieVideo] {
        MovieVideo.mockMovieVideo(for: movieId)
    }
    
    func fetchTrendingMovieVideos() async throws -> [MovieVideo] {
        MovieVideo.mockTrendingVideos()
    }
    
}
