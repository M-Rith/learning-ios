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
    }

    func addNewCategory(title: String, total: Double) {
        if let newCategory = CoreDataManager.shared.addBudgetCategory(title: title, total: total) {
            self.budgetCategories.append(newCategory)
        }
    }
    
    func deleteCategory(indexSet: IndexSet) {
        CoreDataManager.shared.deleteBudgetCategory(indexSet: indexSet)
        self.budgetCategories.remove(atOffsets: indexSet)
    }

}
