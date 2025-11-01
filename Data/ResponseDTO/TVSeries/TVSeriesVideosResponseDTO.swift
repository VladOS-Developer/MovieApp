//
//  TVSeriesVideosResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesVideosResponseDTO: Decodable {
    let id: Int
    let results: [TVSeriesVideoDTO]
}
