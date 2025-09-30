//
//  Endpoint.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import UIKit

enum Endpoint {
    case topRatedMovies
    case upcomingMovies
    case genres
    case moviesByGenre(Int)
    case movieVideos(Int)
    case movieSimilar(Int)
    case movieCredits(Int)
    case actorDetails(Int)
    case actorMovies(Int)
    case actorImages(Int)
    case movieDetails(Int)
    case trendingMovies
    
    var path: String {
        switch self {
        case .topRatedMovies:
            return "/movie/top_rated"
            
        case .upcomingMovies:
            return "/movie/upcoming"
            
        case .genres:
            return "/genre/movie/list"
            
        case .moviesByGenre(let genreId):
            return "/discover/movie?with_genres=\(genreId)"
            
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
            
        case .trendingMovies:
            return "/trending/movie/day"
            
        }
        
    }
}
