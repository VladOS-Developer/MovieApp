//
//  Endpoint.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import UIKit

enum Endpoint {
    case topRatedMovies(page: Int)
    case upcomingMovies(page: Int)
    case genres
    case moviesByGenre(Int, page: Int)
    case movieVideos(Int)
    case movieSimilar(Int)
    case movieCredits(Int)
    case actorDetails(Int)
    case actorMovies(Int)
    case actorImages(Int)
    case movieDetails(Int)
    case trendingMovies(page: Int)
    case searchMovies(query: String, page: Int)
    case tvTopRated(page: Int)
    case tvGenres
    
    var path: String {
        switch self {
        case .topRatedMovies(_):
            return "/movie/top_rated"
            
        case .upcomingMovies(_):
            return "/movie/upcoming"
            
        case .genres:
            return "/genre/movie/list"
            
        case .moviesByGenre(_, _):
            return "/discover/movie"
            
        case .movieVideos(let movieId):
            return "/movie/\(movieId)/videos"
            
        case .movieSimilar(let movieId):
            return "/movie/\(movieId)/similar"
            
        case .movieCredits(let movieId):
            return "/movie/\(movieId)/credits"
            
        case .actorDetails(let actorId):
            return "/person/\(actorId)"
            
        case .actorMovies(let actorId):
            return "/person/\(actorId)/movie_credits"
            
        case .actorImages(let actorId):
            return "/person/\(actorId)/images"
            
        case .movieDetails(let movieId):
            return "/movie/\(movieId)"
            
        case .trendingMovies(_):
            return "/trending/movie/day"
            
        case .searchMovies:
            return "/search/movie"
            
        case .tvTopRated(page: let page):
            return "/tv/top_rated"
            
        case .tvGenres:
            return "/genre/tv/list"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
            
        case .topRatedMovies(let page),
             .upcomingMovies(let page),
             .trendingMovies(let page),
             .tvTopRated(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
            
        case .moviesByGenre(let genreId, let page):
            return [
                URLQueryItem(name: "with_genres", value: "\(genreId)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
        case .searchMovies(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
        default:
            return []
        }
    }
}
