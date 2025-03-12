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

private func createPostRequest<T: Encodable>(url: URL, body: T) throws -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(body)
    return request
}


class WebService {
    private let environmentManager: AppEnvironmentManager
    
    init(environmentManager: AppEnvironmentManager) {
        self.environmentManager = environmentManager
    }
    
    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.allOrder.path, relativeTo: environmentManager.baseURL) else {
            throw NetworkError.badUrl
        }

        let request = try createPostRequest(url: url, body: order)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badRequest
            }
            
            return try JSONDecoder().decode(Order.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrder.path, relativeTo: environmentManager.baseURL) else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        do {
            return try JSONDecoder().decode([Order].self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
