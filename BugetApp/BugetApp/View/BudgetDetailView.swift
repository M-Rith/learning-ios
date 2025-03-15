//
//  BudgetDetailView.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import SwiftUI

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
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
            
            Spacer()
            
        }
    }
}
