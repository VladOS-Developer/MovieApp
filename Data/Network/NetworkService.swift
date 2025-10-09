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
    private var apiKey: String
    
    init(apiKey: String) {
            self.apiKey = apiKey
        }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        // Базовые query-параметры
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        // Специфичные для эндпоинта параметры
        queryItems.append(contentsOf: endpoint.queryItems)
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
