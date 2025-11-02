//
//  TVSeasonRepository.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

final class TVSeasonRepository: TVSeasonRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchSeasons(for tvId: Int) async throws -> [TVSeason] {
        let response: TVSeasonsResponseDTO = try await networkService.request(.tvDetails(tvId))
        return response.seasons.map { TVSeason(dto: $0) }
    }

    func fetchEpisodes(for tvId: Int, seasonNumber: Int) async throws -> [TVEpisode] {
        let response: TVSeasonDetailsResponseDTO = try await networkService.request(.tvSeasonDetails(tvId: tvId, seasonNumber: seasonNumber))
        
        // Для каждого эпизода подтягиваем видео
        return try await withThrowingTaskGroup(of: TVEpisode.self) { group in
            for dto in response.episodes {
                group.addTask {
                    let videosResponse: TVEpisodeVideosResponseDTO = try await self.networkService.request(.tvEpisodeVideos(tvId: tvId, seasonNumber: seasonNumber, episodeNumber: dto.episodeNumber))
                    let videos = videosResponse.results.map { TVEpisodeVideo(dto: $0) }
                    return TVEpisode(dto: dto, videos: videos)
                }
            }
            return try await group.reduce(into: [TVEpisode](), { $0.append($1) })
        }
    }

    func fetchEpisodeVideos(for tvId: Int, seasonNumber: Int, episodeNumber: Int) async throws -> [TVEpisodeVideo] {
        let response: TVEpisodeVideosResponseDTO = try await networkService.request(.tvEpisodeVideos(tvId: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        return response.results.map { TVEpisodeVideo(dto: $0) }
    }
}
