//
//  CoffeeViewModel.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation
import Observation


@Observable class CoffeeViewModel {
    static let shared = CoffeeViewModel()
    var orders: [Order] = [] 
    var isLoading: Bool = false
    
    func getOrders() async {
            isLoading = true
            defer { isLoading = false }
            
            do {
                orders = try await WebService().fetch(endpoint: "orders")
            } catch {
                print("Failed to load users: \(error.localizedDescription)")
            }
        }
}
