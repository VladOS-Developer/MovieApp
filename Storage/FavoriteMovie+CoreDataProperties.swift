//
//  FavoriteMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by VladOS on 09.09.2025.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var title: String?

}

extension FavoriteMovie : Identifiable {

}
