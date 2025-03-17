import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var titleError: Bool = false
    @State private var total: String = ""
    @State private var totalError: Bool = false
    @State private var notes: String = ""
    @State private var date = Date()
    
    var category: BudgetCategory?
    var selectedTransaction: Transaction?
    
    
    
    
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    
    
    var isFormValid: Bool {
        titleError = title.isEmpty

        if total.isEmpty {
            totalError = true
            return false
        }
        
        guard let totalAsDouble = Double(total), totalAsDouble > 0 else {
            totalError = true
            return false
        }
        
        totalError = false
        return !titleError && !totalError
    }

    
    

    var body: some View {
        Form {
            Section {

                HStack(spacing: 20) {
                    Text("Title").foregroundStyle(titleError ? .red : .black)
                    TextField("Title", text: $title)
                }
                
                HStack(spacing: 20) {
                    Text("Total").foregroundStyle(totalError ? .red : .black)
                    TextField("Total", text: $total)
                        .keyboardType(.decimalPad)
                }
                
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
            } header: {
                Text("Transaction")
            }
            
            Section {
                TextField("Description", text: $notes, axis: .vertical)
            } header: {
                Text("Description")
            }
        
            
        }
        .onAppear {
            if let transaction = selectedTransaction {
                title = transaction.title ?? ""
                total = String(format: "%.2f", transaction.total)
                notes = transaction.notes ?? ""
                date = transaction.date ?? Date()
            }
        }
        .navigationTitle(selectedTransaction == nil ? "Add Transaction" : "Edite Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    if isFormValid {
                        if let transaction = selectedTransaction {
                            transactionViewModel.updateTransaction(transaction: transaction, title: title, total: Double(total)!, date: date, note: notes, category: category!)
                        }
                        else {
                            transactionViewModel.addNewTransaction(title: title, total: Double(total)!, date: date, note: notes, category: category! )
                        }
                        dismiss()
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            

        }
    }
}
