import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var viewModel: BudgetCategoriesViewModel
    
    var total: Double {
        viewModel.budgetCategories.reduce(0) { $0 + $1.total }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.budgetCategories.isEmpty {
                    Text("No category found")
                } else {
                    List {
                        ForEach(viewModel.budgetCategories) { category in
                            NavigationLink(value: category) {
                                BudgetList(budgetCategory: category)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.deleteCategory(indexSet: indexSet)
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetCategory()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .font(.headline).fontWeight(.bold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
                    }
                }
            }
            .navigationDestination(for: BudgetCategory.self) { budgetCategory in
                BudgetDetailView(budgetCategory: budgetCategory)
            }
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}
