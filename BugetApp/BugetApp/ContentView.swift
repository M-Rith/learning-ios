import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @State private var selectedCategory: BudgetCategory? 
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
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let index = viewModel.budgetCategories.firstIndex(of: category) {
                                        viewModel.deleteCategory(indexSet: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                    selectedCategory = category
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .onMove { indexSet, destination in
                            viewModel.moveCategory(from: indexSet, to: destination)
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetCategory(category: nil)
            }
          
            .sheet(item: $selectedCategory) { category in
                AddBudgetCategory(category: category)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .font(.headline).fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category") {
                        selectedCategory = nil
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
