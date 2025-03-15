//
//  BugetAppApp.swift
//  BugetApp
//
//  Created by AppleD0g on 3/13/25.
//

import SwiftUI

@main
struct BugetAppApp: App {
    
    @StateObject private var viewModel = BudgetCategoriesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel) 
        }
    }
}
