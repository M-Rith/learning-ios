//
//  ContentView.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var coffeeViewModel = CoffeeViewModel.shared
    
    @State private var isBottomSheetOpen = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if coffeeViewModel.orders.isEmpty {
                    Text("No orders available")
                        .accessibilityIdentifier("noOrderText")
                } else {
                    List(coffeeViewModel.orders) { order in
                        OrderCellView(order: order)
                    }
                }
            }
            .task {
                await coffeeViewModel.getOrders()
                print("📌 Orders: \(coffeeViewModel.orders)")
            }
            .sheet(isPresented: $isBottomSheetOpen, content: {
                NavigationStack {
                    AddCoffeeView()
                }
            
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order") {
                        isBottomSheetOpen = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}





#Preview {
    ContentView()
}
