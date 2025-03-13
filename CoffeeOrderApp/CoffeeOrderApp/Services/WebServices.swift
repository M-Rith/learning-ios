//
//  WebServices.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

struct WebService {
    /// Fetches data using the environment's base URL
    func fetch<T: Decodable>(endpoint: String) async throws -> T {
        let urlString = "\(AppEnvironment.shared.baseURL)/\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func post<T: Codable, U: Decodable>(endpoint: String, body: T) async throws -> U {
        let urlString = "\(AppEnvironment.shared.baseURL)/\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(U.self, from: data)
    }
    
    func update<T: Codable, U: Decodable>(endpoint: String, body: T) async throws -> U {
        let urlString = "\(AppEnvironment.shared.baseURL)/\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // Use "PATCH" if you want partial updates
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)

        // Ensure the response status is 200-299 (successful update)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(U.self, from: data)
    }
    
    func delete(endpoint: String) async throws {
        let urlString = "\(AppEnvironment.shared.baseURL)/\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (_, response) = try await URLSession.shared.data(for: request)

        // Ensure the response status is 200-299 (successful deletion)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
