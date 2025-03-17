import Foundation
import Observation
import CoreData


struct Ocean: Identifiable {
    let name: String
    let id = UUID()
}


final class BudgetCategoriesViewModel: ObservableObject {

    
    @Published var budgetCategories: [BudgetCategory] = []
    
    func moveCategory(from source: IndexSet, to destination: Int) {
        budgetCategories.move(fromOffsets: source, toOffset: destination)
    }


    func fetchCategories() {
        self.budgetCategories = CoreDataManager.shared.fetchBudgetCategory() ?? []
    }

    func addNewCategory(title: String, total: Double) {
        if let newCategory = CoreDataManager.shared.addBudgetCategory(title: title, total: total) {
            self.budgetCategories.append(newCategory)
        }
    }
    
    func editCategory(title: String, total: Double, category: BudgetCategory) {
        CoreDataManager.shared.editBudgetCategory(category: category, newTitle: title, newTotal: total)

    
        if let index = budgetCategories.firstIndex(where: { $0.objectID == category.objectID }) {
            budgetCategories[index].title = title
            budgetCategories[index].total = total
        }

        budgetCategories = budgetCategories
    }

    
    
    func deleteCategory(indexSet: IndexSet) {
        CoreDataManager.shared.deleteBudgetCategory(indexSet: indexSet)
        self.budgetCategories.remove(atOffsets: indexSet)
    }

}
