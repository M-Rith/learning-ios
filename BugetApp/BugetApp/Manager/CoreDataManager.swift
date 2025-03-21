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
                print("Core Data failed to load: \(error.localizedDescription)")
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
    
    func addBudgetCategory(title: String, total: Double) -> BudgetCategory? {
        let newCategory = BudgetCategory(context: container.viewContext)
        newCategory.title = title
        newCategory.total = total
        
        do {
            save()
            return newCategory
        }
    }
    
    func editBudgetCategory(category: BudgetCategory, newTitle: String, newTotal: Double) {
        category.title = newTitle
        category.total = newTotal
        save()
    }

    

    func deleteBudgetCategory(indexSet : IndexSet) {
        guard let index = indexSet.first else { return }
        if let budget = fetchBudgetCategory() {
            container.viewContext.delete(budget[index])
            save()
        }
    }
    
    func fetchTransactionBaseOnCategory(for category: BudgetCategory) -> [Transaction]? {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate(format: "category == %@", category)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        return try? container.viewContext.fetch(request)
    }

    
    
    func addTransaction(title: String, total: Double, date: Date, note: String, category: BudgetCategory) -> Transaction? {
        let newTransaction = Transaction(context: container.viewContext)
        
        newTransaction.title = title
        newTransaction.total = total
        newTransaction.notes = note
        newTransaction.date = date
        newTransaction.category = category
        category.addToTransaction(newTransaction)

        do {
            save()
            return newTransaction
        }
    }
    
    func editTransaction(transaction: Transaction, newTitle: String, newTotal: Double, newDate: Date, newNote: String) {
        transaction.title = newTitle
        transaction.total = newTotal
        transaction.date = newDate
        transaction.notes = newNote
        save()
    }

    
    func deleteTransaction(indexSet: IndexSet, from category: BudgetCategory) {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate(format: "category == %@", category)

        do {
            let transactions = try container.viewContext.fetch(request)
            
            for index in indexSet {
                container.viewContext.delete(transactions[index])
            }
            
            save()
        } catch {
            print("Error deleting transaction: \(error.localizedDescription)")
        }
    }


}
