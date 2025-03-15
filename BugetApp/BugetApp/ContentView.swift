//
//  ContentView.swift
//  BugetApp
//
//  Created by AppleD0g on 3/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false

    @EnvironmentObject var viewModel: BudgetCategoriesViewModel
    
    
    var total: Double {
        viewModel.budgetCategories.reduce(0) { $0 + $1.total }
    }
    
    var body: some View {
            NavigationStack {
                VStack {
                    if (viewModel.budgetCategories.isEmpty) {
                        Text("No category found")
                    }
                    else {
                        Text(total as NSNumber, formatter: NumberFormatter.currency)
                        
                        List {
                            ForEach(viewModel.budgetCategories) { category in
                                BudgetList(budgetCategory: category)
                            }.onDelete { indexSet in
                                viewModel.deleteCategory(indexSet: indexSet)
                            }
                        }
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
