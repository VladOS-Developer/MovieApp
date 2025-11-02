//
//  TVSeasonDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSeasonDTO: Decodable {
    let id: Int
    let name: String
    let seasonNumber: Int
    let airDate: String?
    let episodeCount: Int
    let posterPath: String?
    let overview: String?
}
