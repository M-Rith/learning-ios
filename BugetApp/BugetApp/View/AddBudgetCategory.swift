import SwiftUI

struct AddBudgetCategory: View {
    
    var category: BudgetCategory?
    
    @EnvironmentObject var viewModel: BudgetCategoriesViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var total: Double
    @State private var titleError: Bool = false
    @State private var totalError: Bool = false
    
    init(category: BudgetCategory? = nil) {
        _title = State(initialValue: category?.title ?? "")
        _total = State(initialValue: category?.total ?? 100)
        self.category = category
    }

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
            .navigationTitle(category == nil ? "Add New Category" : "Edit Category")
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
                            if let category = category {
                                // ✅ Edit existing category
                                viewModel.editCategory(title: title, total: total, category: category)
                            } else {
                                // ✅ Add new category
                                viewModel.addNewCategory(title: title, total: total)
                            }
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
