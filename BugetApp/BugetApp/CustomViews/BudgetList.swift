import SwiftUI

struct BudgetList: View {
    
    @ObservedObject var budgetCategory: BudgetCategory
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @State private var total: Double = 0.0
    @State private var progress: Double = 0.0

    var overBudget: Bool {
        return total > budgetCategory.total
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(budgetCategory.title ?? "")
                .font(.headline)

            Spacer()

            VStack(alignment: .trailing, spacing: 10) {
                // Display total budget amount
                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)

                // Custom Circular Progress Indicator
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                    
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(overBudget ? Color.red : Color.green, lineWidth: 5)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut, value: progress)

                    Text("\(Int(progress * 100))%")
                        .font(.caption2)
                        .bold()
                }
                .frame(width: 40, height: 40)
            }
        }
        .onAppear {
            if let transactions = budgetCategory.transaction as? Set<Transaction> {
                total = transactions.reduce(0) { $0 + $1.total }
            } else {
                total = 0
            }

            // Compute progress safely
            progress = budgetCategory.total > 0 ? min(total / budgetCategory.total, 1) : 0
        }
    }
}
