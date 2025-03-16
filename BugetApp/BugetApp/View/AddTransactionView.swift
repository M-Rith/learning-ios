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
    
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    
    
    var isFormValid: Bool {
        
        titleError = title.isEmpty
        
        
        guard let totalAsDouble = Double(total) else { return false }
        
        totalError = totalAsDouble > 0 && !total.isEmpty
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
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
        .navigationTitle("Add Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    if isFormValid {
                        transactionViewModel.addNewTransaction(title: title, total: Double(total)!, date: date, note: notes, category: category! )
                        dismiss()
                    }
                }
            }
        }
    }
}
