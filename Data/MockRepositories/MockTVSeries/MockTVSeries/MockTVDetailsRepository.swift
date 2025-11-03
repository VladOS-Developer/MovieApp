//
//  MockTVSeriesDetailsRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class MockTVDetailsRepository: TVDetailsRepositoryProtocol {
    static let shared = MockTVDetailsRepository()

    func fetchTopRatedTVSeries(page: Int) async throws -> [TVSeriesDetails] {
        TVSeriesDetails.mockTopRatedTVSeries()
    }

    func fetchPopularTVSeries(page: Int) async throws -> [TVSeriesDetails] {
        TVSeriesDetails.mockPopularTVSeries()
    }

    func fetchTVSeriesDetails(byGenre id: Int, page: Int) async throws -> [TVSeriesDetails] {
        let all = TVSeriesDetails.mockTopRatedTVSeries() + TVSeriesDetails.mockPopularTVSeries()
        return all.filter { $0.genreIDs.contains(id) }
    }

    func fetchTVSeriesDetails(byId id: Int) async throws -> TVSeriesDetails {
        let all = TVSeriesDetails.mockTopRatedTVSeries() + TVSeriesDetails.mockPopularTVSeries()
        guard let series = all.first(where: { $0.id == id }) else {
            throw NSError(domain: "MockTVSeriesDetailsRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "TV series not found"])
        }
        return series
    }
}
