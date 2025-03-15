//
//  BudgetList.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import SwiftUI

struct BudgetList: View {
        
    let budgetCategory:BudgetCategory
//    let budgetCategory: BudgetCategory
        
    var body: some View {
        HStack {
            Text(budgetCategory.title ?? "")
            Spacer()
            VStack {
                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
            }
        }
    }
}

