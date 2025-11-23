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

        var episodes: [TVEpisode] = []

        let types = ["Trailer", "Teaser", "Clip"]
        let sites = ["YouTube", "Vimeo"]

        try await withThrowingTaskGroup(of: TVEpisode.self) { group in
            for dto in response.episodes {
                group.addTask {
                    // Загружаем видео для эпизода
                    let videosResponse: TVEpisodeVideosResponseDTO = try await self.networkService.request(
                        .tvEpisodeVideos(
                            tvId: tvId,
                            seasonNumber: seasonNumber,
                            episodeNumber: dto.episodeNumber
                        )
                    )

                    let filteredVideos = videosResponse.results
                        .map { TVEpisodeVideo(dto: $0) }
                        .filter {
                            types.contains($0.type) &&
                            sites.contains($0.site)
                        }

                    return TVEpisode(dto: dto, videos: filteredVideos)
                }
            }

            for try await episode in group {
                episodes.append(episode)
            }
        }

        return episodes
    }
    
    func fetchEpisodeVideos(for tvId: Int) async throws -> [TVEpisodeVideo] {
        let response: TVEpisodeVideosResponseDTO = try await networkService.request(.tvVideos(tvId))
        return response.results.map { TVEpisodeVideo(dto: $0) }
    }
    
}
