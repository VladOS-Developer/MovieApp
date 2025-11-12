//
//  TVSeasonRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

protocol TVSeasonRepositoryProtocol: AnyObject {
    
    func fetchSeasons(for tvId: Int) async throws -> [TVSeason]
    
    func fetchEpisodes(for tvId: Int, seasonNumber: Int) async throws -> [TVEpisode]
    
    func fetchEpisodeVideos(for tvId: Int, seasonNumber: Int, episodeNumber: Int) async throws -> [TVEpisodeVideo]
    
    func fetchEpisodeVideos(for tvId: Int) async throws -> [TVEpisodeVideo]
}
