//
//  NetworkService.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import UIKit

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    private var apiKey = "key"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint.path)?api_key=\(apiKey)&language=en-US") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
