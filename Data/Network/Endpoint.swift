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
    case moviesByGenre(Int)
    case genres
    case movieVideos(Int)
    
    var path: String {
        switch self {
        case .topRatedMovies:
            return "/movie/top_rated"
            
        case .upcomingMovies:
            return "/movie/upcoming"
            
        case .moviesByGenre(let genreId):
            return "/discover/movie&with_genres=\(genreId)"
            
        case .genres:
            return "/genre/movie/list"
            
        case .movieVideos(let movieId):
            return "/movie/\(movieId)/videos"
        }
    }
}
