//
//  BudgetDetailView.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import SwiftUI

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
    @State private var isPresented: Bool = false
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .center) {
                    Text(budgetCategory.title ?? "No Title Found").font(.title).fontWeight(.bold)
                    HStack {
                        Text("Budgets : ").font(.subheadline)
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
            }
            
            List {
                ForEach(transactionViewModel.transactionList) { transaction in
                    TransactionListView(transaction: transaction)
                }
            }
            
            
            
            
            
            Spacer()
            
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                }
            }
        }.sheet(isPresented: $isPresented) {
            NavigationStack {
                AddTransactionView(category: budgetCategory)
            }
        
        }.onAppear {
            transactionViewModel.fetchTransactionBaseOnCategory(category: budgetCategory)
        }

    }
}
