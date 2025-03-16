//
//  TransactionViewModel.swift
//  BugetApp
//
//  Created by AppleD0g on 3/16/25.
//

import Foundation

final class TransactionViewModel : ObservableObject {
    
    
    @Published var transactionList : [Transaction] = []
    
    func fetchTransactionBaseOnCategory(category: BudgetCategory) {
        self.transactionList = CoreDataManager.shared.fetchTransactionBaseOnCategory(for: category) ?? []
    }
    
    
    func addNewTransaction(title: String, total: Double, date: Date, note: String, category: BudgetCategory) {
        if let newTransaction = CoreDataManager.shared.addTransaction(title: title, total: total, date: date, note: note, category: category) {
            self.transactionList.append(newTransaction)
        }
    }

}
