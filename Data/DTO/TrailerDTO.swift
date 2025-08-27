//
//  TrailerDTO.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

struct TrailerDTO: Decodable {
    let id: String
    let key: String     // для запуска YouTube-видео
    let name: String    // название трейлера
    let site: String    // обычно "YouTube"
    let type: String    // Trailer / Teaser / Clip
}
