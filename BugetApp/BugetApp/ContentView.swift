//
//  ContentView.swift
//  BugetApp
//
//  Created by AppleD0g on 3/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false

    @EnvironmentObject var viewModel: BudgetCategoriesViewModel // No need to pass it manually
    
    var body: some View {
            NavigationStack {
                VStack {
                    List(viewModel.budgetCategories) { category in
                        Text(category.title ?? "Default")
                    }
                }
                .sheet(isPresented: $isPresented) {
                    AddBudgetCategory()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Category") {
                            isPresented = true
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchCategories()
            }
        }
}

#Preview {
    ContentView()
}
