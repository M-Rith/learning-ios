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
    
    @State private var total: Double = 0.0
    
    
    var overBudget: Bool {
        return budgetCategory.total - total < 0
    }
        
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
            
            Text("\(overBudget ? "Over Budget" : "Remaining" ) \(Text(budgetCategory.total - total as NSNumber, formatter: NumberFormatter.currency ))").fontWeight(.bold).foregroundStyle(overBudget ? .red : .green)
             
            List {
                ForEach(transactionViewModel.transactionList) { transaction in
                    TransactionListView(transaction: transaction)
                }.onDelete { offsets in
                    transactionViewModel.deleteTransaction(indexSet: offsets, category: budgetCategory)
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
            total = transactionViewModel.getTotalTransaction()
        }.onChange(of: transactionViewModel.transactionList) {
            total = transactionViewModel.getTotalTransaction()
        }

    }
}
