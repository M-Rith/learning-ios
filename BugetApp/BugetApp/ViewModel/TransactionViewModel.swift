//
//  TransactionViewModel.swift
//  BugetApp
//
//  Created by AppleD0g on 3/16/25.
//

import Foundation

final class TransactionViewModel : ObservableObject {
    
    
    @Published var transactionList : [Transaction] = []
    
    func getTotalTransaction() -> Double {
        return transactionList.reduce(0) { $0 + $1.total } 
    }
    
    
    
    func fetchTransactionBaseOnCategory(category: BudgetCategory) {
        self.transactionList = CoreDataManager.shared.fetchTransactionBaseOnCategory(for: category) ?? []
    }
    
    func addNewTransaction(title: String, total: Double, date: Date, note: String, category: BudgetCategory) {
        if let newTransaction = CoreDataManager.shared.addTransaction(title: title, total: total, date: date, note: note, category: category) {
            self.transactionList.append(newTransaction)
        }
    }
    
    func updateTransaction(transaction: Transaction, title: String, total: Double, date: Date, note: String, category: BudgetCategory) {
        CoreDataManager.shared.editTransaction(
            transaction: transaction,
            newTitle: title,
            newTotal: total,
            newDate: date,
            newNote: note
        )

        
        if let index = transactionList.firstIndex(where: { $0.objectID == transaction.objectID }) {
              transactionList[index].title = title
              transactionList[index].total = total
              transactionList[index].date = date
              transactionList[index].notes = note
          }

          transactionList = transactionList

    }

    
    func deleteTransaction(indexSet: IndexSet, category: BudgetCategory) {
        CoreDataManager.shared.deleteTransaction(indexSet: indexSet, from: category)
        fetchTransactionBaseOnCategory(category: category)
    }

}
