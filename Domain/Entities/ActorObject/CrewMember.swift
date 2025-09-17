//
//  CrewMember.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct CrewMember: Hashable {
    let id: Int
    let creditId: String
    let name: String
    let job: String?
    let department: String?
    let profilePath: String?
}

extension CrewMember {
    init(dto: CrewDTO) {
        self.id = dto.id
        self.creditId = dto.creditId
        self.name = dto.name
        self.job = dto.job
        self.department = dto.department
        self.profilePath = dto.profilePath
    }
}

extension CrewMember {
    static func mockCrew() -> [CrewMember] {
        return [
            CrewMember(id: 2710, creditId: "52fe4214c3a36847f800b999",name: "James Cameron", job: "Director",department: "Directing", profilePath: "/cameron.jpg"),
            CrewMember(id: 3456, creditId: "52fe4214c3a36847f800b998",name: "Jon Landau", job: "Producer",department: "Production", profilePath: "/landau.jpg")
        ]
    }
}
