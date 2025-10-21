//
//  ArrayAsyncMap.swift
//  MovieApp
//
//  Created by VladOS on 21.10.2025.
//

import Foundation

extension Array {
    func asyncMap <T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var results = [T]()
        results.reserveCapacity(count)
        
        for element in self {
            try await results.append(transform(element))
        }
        return results
    }
}
