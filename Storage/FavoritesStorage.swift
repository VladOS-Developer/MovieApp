//
//  FavoritesStorage.swift
//  MovieApp
//
//  Created by VladOS on 06.09.2025.
//

import CoreData

protocol FavoritesStorageProtocol {
    func fetchFavorites() -> [FavoriteMovie]
    func addFavorite(id: Int32, title: String, posterPath: String?, voteAverage: Double)
    func removeFavorite(id: Int32)
    func isFavorite(id: Int32) -> Bool
}

final class FavoritesStorage: FavoritesStorageProtocol {
    private var context: NSManagedObjectContext {
        PersistenceController.shared.context
    }

    func fetchFavorites() -> [FavoriteMovie] {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    func addFavorite(id: Int32, title: String, posterPath: String?, voteAverage: Double) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = id
        favorite.title = title
        favorite.voteAverage = voteAverage
        
        if let posterPath {
            // если это путь с TMDB, преобразуем в полный URL
            if posterPath.starts(with: "/") {
                favorite.posterPath = "https://image.tmdb.org/t/p/w500\(posterPath)"
            } else {
                favorite.posterPath = posterPath // локальный ассет
            }
        }
        
        save()
    }
    
    func removeFavorite(id: Int32) {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            let result = try context.fetch(request)
            result.forEach { context.delete($0) }
            save()
        } catch {
            print("Remove error: \(error)")
        }
    }

    func isFavorite(id: Int32) -> Bool {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.count(for: request) > 0
        } catch {
            return false
        }
    }

    private func save() {
        PersistenceController.shared.saveContext()
    }
}
