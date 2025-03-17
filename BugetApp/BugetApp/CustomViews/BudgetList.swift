//
//  BudgetList.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import SwiftUI

struct BudgetList: View {
        
    @ObservedObject var budgetCategory: BudgetCategory
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @State private var total: Double = 0.0
    
    var overBudget: Bool {
        return budgetCategory.total - total < 0
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(budgetCategory.title ?? "")
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency).fontWeight(.bold)
                
                Text("\(overBudget ? "Over Budget" : "Remaining" ) \(Text(budgetCategory.total - total as NSNumber, formatter: NumberFormatter.currency ))").fontWeight(.bold).foregroundStyle(overBudget ? .red : .green)
            }
        }.onAppear {
            if let transactions = budgetCategory.transaction as? Set<Transaction> {
                total = transactions.reduce(0) { $0 + $1.total }
            } else {
                total = 0
            }
        }
    }
}

