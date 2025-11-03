//
//  CrewDTO.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct CrewDTO: Decodable {
    let id: Int
    let creditId: String
    let name: String
    let job: String?
    let department: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case name
        case job
        case department
        case profilePath = "profile_path"
    }
}
