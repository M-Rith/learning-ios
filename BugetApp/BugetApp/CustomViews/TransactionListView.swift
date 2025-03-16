import SwiftUI

struct TransactionListView: View {
    
    var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction.title ?? "Default Title")
                        .font(.headline)
                    
                    Text(transaction.notes ?? "No Notes Found")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Text(transaction.date?.formattedString() ?? "No Date")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                VStack {
                    Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                        .font(.headline)
                }
                
            }
        }
    }
}
