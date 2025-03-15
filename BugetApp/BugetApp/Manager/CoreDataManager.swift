//
//  CoreDataManager.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import CoreData
import Foundation


class CoreDataManager {
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    
    
    
    private init() {
        container = NSPersistentContainer(name: "BudgetModel")
        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription) ")
            }
        }
    }
    
    func save() {
        try? container.viewContext.save()
    }
    
    
    func fetchBudgetCategory() -> [BudgetCategory]? {
        let request = NSFetchRequest<BudgetCategory>(entityName: "BudgetCategory")
        return try? container.viewContext.fetch(request)
    }
    
    func addBudgetCategory(title: String, total: Double) {
        
        let addNewBudgetCategory = BudgetCategory(context: container.viewContext)
        
        addNewBudgetCategory.title = title
        addNewBudgetCategory.total = total
        
        save()
        
    }
}
