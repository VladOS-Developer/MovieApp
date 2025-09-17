//
//  MockMovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieVideoRepository: MovieVideoRepositoryProtocol {
    static let shared = MockMovieVideoRepository()
    private init() {}
 
    func fetchMovieVideo(for movieId: Int, completion: @escaping ([MovieVideo]) -> Void) {
            switch movieId {
            case 1: // Avatar
                completion([
                    MovieVideo(id: "1", key: "d9MyW72ELq0", name: "Avatar: The Way of Water", site: "YouTube", type: "Trailer"),
//                    MovieVideo(id: "2", key: "abc123XYZ", name: "Avatar Teaser", site: "YouTube", type: "Teaser"),
                    MovieVideo(id: "2", key: "M7lc1UVf-VE", name: "Avatar Teaser", site: "YouTube", type: "Teaser"),
//                    MovieVideo(id: "3", key: "qwe456RTY", name: "Avatar Behind the Scenes", site: "YouTube", type: "Clip")
                ])
            case 2: // Avengers
                completion([
                    MovieVideo(id: "4", key: "6ZfuNTqbHE8", name: "Avengers: Infinity War Trailer", site: "YouTube", type: "Trailer")
                ])
            case 3: // Dark Knight
                completion([
                    MovieVideo(id: "5", key: "EXeTwQWrcwY", name: "The Dark Knight Trailer", site: "YouTube", type: "Trailer")
                ])
            default:
                completion([])
            }
        }
    
}

//                    key: "https://www.youtube.com/embed/d9MyW72ELq0"

//                    key: "https://www.youtube.com/embed/abc123XYZ"

//                    key: "https://www.youtube.com/embed/qwe456RTY"

//                    key: "https://www.youtube.com/embed/6ZfuNTqbHE8"

//                    key: "https://www.youtube.com/embed/EXeTwQWrcwY"
