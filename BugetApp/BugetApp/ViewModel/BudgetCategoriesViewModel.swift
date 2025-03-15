//
//  BudgetCategoriesViewModel.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import Foundation
import Observation
import CoreData


struct Ocean: Identifiable {
    let name: String
    let id = UUID()
}


final class BudgetCategoriesViewModel: ObservableObject {

    
    @Published var budgetCategories: [BudgetCategory] = []


    func fetchCategories() {
        self.budgetCategories = CoreDataManager.shared.fetchBudgetCategory() ?? []
        
        print(budgetCategories)
    }

    func addNewCategory(title: String, total: Double) {
        CoreDataManager.shared.addBudgetCategory(title: title, total: total)
        fetchCategories()
    }
}
