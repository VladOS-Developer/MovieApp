//
//  ActorCrewCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

struct ActorCrewCellViewModel: Hashable {
    let id: Int
    let name: String
    let job: String?
    let department: String?
    let profileURL: URL?
    let profileImage: UIImage?

    init(crew: CrewMember) {
        self.id = crew.id
        self.name = crew.name
        self.job = crew.job
        self.department = crew.department
        
        if let path = crew.profilePath {
            self.profileURL = URL(string: "https://image.tmdb.org/t/p/w185\(path)")
            self.profileImage = nil
        } else {
            self.profileURL = nil
            self.profileImage = UIImage(named: "placeholder_actor")
        }
    }
}
