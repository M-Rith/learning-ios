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
}

//class WebService {
//
//    private var baseURL: URL
//    
//    init(baseURL: URL) {
//        self.baseURL = baseURL
//    }
//    
//    func placeOrder(order: Order) async throws -> Order {
//        
//        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
//                   throw NetworkError.badUrl
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try JSONEncoder().encode(order)
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//                     httpResponse.statusCode == 200 else {
//                   throw NetworkError.badRequest
//        }
//        
//        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
//            throw NetworkError.decodingError
//        }
//        
//        return newOrder
//        
//    }
//    
//    func getOrders() async throws -> [Order] {
//        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
//            throw NetworkError.badUrl
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.badRequest
//        }
//        
//        do {
//            return try JSONDecoder().decode([Order].self, from: data)
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }
//}
