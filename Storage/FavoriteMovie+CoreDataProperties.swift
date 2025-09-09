//
//  FavoriteMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by VladOS on 08.09.2025.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var rating: Double

}

extension FavoriteMovie : Identifiable {

}
