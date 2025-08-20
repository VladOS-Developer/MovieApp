//
//  MovieDTO.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let original_title: String?
    let poster_path: String?
    let backdrop_path: String?
    let runtime: Int?
    let release_date: String?
    let genre_ids: [Int]
    let overview: String?
    let origin_country: [String]?
    let vote_average: Double?
}
