//
//  Endpoint.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import UIKit
    
    // MARK: - Endpoint

enum Endpoint {
    case topRatedMovies(page: Int = 1)
    case upcomingMovies(page: Int = 1)
    case genres
    case moviesByGenre(Int, page: Int = 1)
    case movieVideos(Int)
    case movieSimilar(Int)
    case movieCredits(Int)
    case actorDetails(Int)
    case actorMovies(Int)
    case actorImages(Int)
    case movieDetails(Int)
    case trendingMovies(page: Int = 1)
    case searchMovies(query: String, page: Int = 1)
    
    case searchTVSeries(query: String, page: Int = 1)
    case tvTopRated(page: Int = 1)
    case tvPopular(page: Int = 1)
    case tvGenres
    case tvByGenre(Int, page: Int = 1)
    case actorTVSeries(Int)
    case tvCredits(Int)
    case tvDetails(Int)
    case tvVideos(Int)
    case tvSimilar(Int)
    
    case tvSeasonDetails(tvId: Int, seasonNumber: Int)
    case tvEpisodeVideos(tvId: Int, seasonNumber: Int, episodeNumber: Int)
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .topRatedMovies:        return "/movie/top_rated"
        case .upcomingMovies:        return "/movie/upcoming"
        case .genres:                return "/genre/movie/list"
        case .moviesByGenre:         return "/discover/movie"
        case .movieVideos(let id):   return "/movie/\(id)/videos"
        case .movieSimilar(let id):  return "/movie/\(id)/similar"
        case .movieCredits(let id):  return "/movie/\(id)/credits"
        case .actorDetails(let id):  return "/person/\(id)"
        case .actorMovies(let id):   return "/person/\(id)/movie_credits"
        case .actorImages(let id):   return "/person/\(id)/images"
        case .movieDetails(let id):  return "/movie/\(id)"
        case .trendingMovies:        return "/trending/movie/day"
        case .searchMovies:          return "/search/movie"
            
        case .searchTVSeries:        return "/search/tv"
        case .tvTopRated:            return "/tv/top_rated"
        case .tvPopular:             return "/tv/popular"
        case .tvGenres:              return "/genre/tv/list"
        case .tvByGenre:             return "/discover/tv"
        case .actorTVSeries(let id): return "/person/\(id)/tv_credits"
        case .tvCredits(let id):     return "/tv/\(id)/credits"
        case .tvDetails(let id):     return "/tv/\(id)"
        case .tvVideos(let id):      return "/tv/\(id)/videos"
        case .tvSimilar(let id):     return "/tv/\(id)/similar"
            
        case .tvSeasonDetails(let tvId, let seasonNumber): return "/tv/\(tvId)/season/\(seasonNumber)"
        case .tvEpisodeVideos(let tvId, let seasonNumber, let episodeNumber): return "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/videos"
            
        }
    }
    
    // MARK: - Query Items
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .topRatedMovies(let page),
             .upcomingMovies(let page),
             .trendingMovies(let page),
             .tvTopRated(let page),
             .tvPopular(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
            
        case .moviesByGenre(let genreId, let page),
             .tvByGenre(let genreId, let page):
            return [
                URLQueryItem(name: "with_genres", value: "\(genreId)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
        case .searchMovies(let query, let page),
             .searchTVSeries(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
        default:
            return []
        }
    }
}
