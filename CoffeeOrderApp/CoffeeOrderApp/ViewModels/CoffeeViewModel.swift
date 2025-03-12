//
//  CoffeeViewModel.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation
import Observation


@Observable class CoffeeViewModel {
    private let webService = WebService()
    
    var orders: [Order] = []
    
    func getOrders() async {
        self.orders = (try? await webService.getOrders()) ?? []
        
        print(self.orders)
    }
}
