//
//  MockTVSeasonRepository.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

final class MockTVSeasonRepository: TVSeasonRepositoryProtocol {
    
    func fetchSeasons(for tvId: Int) async throws -> [TVSeason] {
        return TVSeason.fetchSeasons(for: tvId)
    }
    
    func fetchEpisodes(for tvId: Int, seasonNumber: Int) async throws -> [TVEpisode] {
        return TVEpisode.fetchEpisodes(for: tvId, seasonNumber: seasonNumber)
    }
    
    func fetchEpisodeVideos(for tvId: Int, seasonNumber: Int, episodeNumber: Int) async throws -> [TVEpisodeVideo] {
        return TVEpisodeVideo.fetchEpisodeVideos(for: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
    }
    
}
   
