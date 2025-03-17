import SwiftUI

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
    @State private var isPresented: Bool = false
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    @State private var selectedTransaction: Transaction?
    
    var overBudget: Bool {
        return budgetCategory.total - transactionViewModel.getTotalTransaction() < 0
    }
        
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .center) {
                    Text(budgetCategory.title ?? "No Title Found")
                        .font(.title)
                        .fontWeight(.bold)
                    HStack {
                        Text("Budgets : ")
                            .font(.subheadline)
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
            }
            
            Text("\(overBudget ? "Over Budget" : "Remaining") \(Text(budgetCategory.total - transactionViewModel.getTotalTransaction() as NSNumber, formatter: NumberFormatter.currency ))")
                .fontWeight(.bold)
                .foregroundStyle(overBudget ? .red : .green)
             
            if transactionViewModel.transactionList.isEmpty {
                Text("No transaction for this category")
            }
            
            List {
                ForEach(transactionViewModel.transactionList.sorted {
                    $0.date ?? Date.distantPast > $1.date ?? Date.distantPast
                }) { transaction in
                    TransactionListView(transaction: transaction)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = transactionViewModel.transactionList.firstIndex(of: transaction) {
                                    let indexSet = IndexSet(integer: index)
                                    transactionViewModel.deleteTransaction(indexSet: indexSet, category: budgetCategory)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                selectedTransaction = transaction
//                                AddTransactionView(category: budgetCategory)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                }
            }
            
            Spacer()
            
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AddTransactionView(category: budgetCategory)
            }
        }
        
        .sheet(item: $selectedTransaction) { transaction in
            
            NavigationStack {
                AddTransactionView(category: budgetCategory, selectedTransaction: transaction)
            }
            
        }
        
        .onAppear {
            transactionViewModel.fetchTransactionBaseOnCategory(category: budgetCategory)
        }
        
       
        
    }
}
