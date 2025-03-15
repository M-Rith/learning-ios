import SwiftUI

struct AddBudgetCategory: View {
    
    @EnvironmentObject var viewModel: BudgetCategoriesViewModel // No need to pass it manually
    @State private var title: String = ""
    @State private var titleError: Bool = false
    @State private var total: Double = 100
    @State private var totalError: Bool = false
    @Environment(\.dismiss) var dismiss // To close the sheet after saving

    var isFormValid: Bool {
        titleError = title.isEmpty
        totalError = total <= 10
        return !titleError && total > 10
    }
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()

    var body: some View {
        
        NavigationStack {
            Form {
                HStack(spacing: 25) {
                    Text("Title ").foregroundStyle(titleError ? .red : .black)
                    TextField("Title", text: $title)
                }
                
                Slider(value: $total, in: 0...500, step: 10) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("0$")
                } maximumValueLabel: {
                    Text("500$")
                }
                
                HStack(spacing: 25) {
                    Text("Budget ").foregroundStyle(totalError ? .red : .black)
                    Text(total as NSNumber, formatter: currencyFormatter)
                        .foregroundStyle(totalError ? .red : .black)
                }
            }
            .navigationTitle("Add New Budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancle") {
                        Task {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            if isFormValid {
                                viewModel.addNewCategory(title: title, total: total)
                                dismiss() // Close sheet after adding
                                print("Valid")
                            } else {
                                print("Not valid")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBudgetCategory()
}
