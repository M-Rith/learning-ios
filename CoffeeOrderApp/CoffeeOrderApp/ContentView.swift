//
//  ContentView.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI


struct ContentView: View {
    private var coffeeViewModel = CoffeeViewModel()
        
    private func getCoffeeList() async {
        await coffeeViewModel.getOrders()
        print("📢 Orders: \(coffeeViewModel.orders)")
        
    }
    
    var body: some View {
        VStack {
            List(coffeeViewModel.orders) {order in
                OrderCellView(order: order)
            }.task {
                await getCoffeeList()
            }
        }
        .padding()
    }
}




#Preview {
    ContentView()
}
