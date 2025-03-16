//
//  BugetAppApp.swift
//  BugetApp
//
//  Created by AppleD0g on 3/13/25.
//

import SwiftUI

@main
struct BugetAppApp: App {
    // Add logging to help debug initialization time
    init() {
        print("App initialization started")
    }
    
    @StateObject private var viewModel = BudgetCategoriesViewModel()
    @StateObject private var transactionModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(transactionModel)
    
        }
    }
}
