//
//  MovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 10.09.2025.
//

import Foundation

final class MovieVideoRepository: MovieVideoRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMovieVideo(for movieId: Int) async throws -> [MovieVideo] {
        let response: MovieVideosResponseDTO = try await networkService.request(.movieVideos(movieId))
        return response.results.map { MovieVideo(dto: $0) } // маппинг в домен
    }
    
}
