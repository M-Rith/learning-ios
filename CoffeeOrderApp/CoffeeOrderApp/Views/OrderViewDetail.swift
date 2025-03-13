//
//  OrderViewDetail.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/13/25.
//

import SwiftUI

struct OrderViewDetail: View {
    @State private var coffeeModel = CoffeeViewModel.shared
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented: Bool = false
    var orderId: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let order = coffeeModel.findOrderByIndex(orderId ?? 0) {
                
                HStack(alignment: .center, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text(order.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(order.coffeeName) (\(order.size.rawValue))").accessibilityIdentifier("CoffeeNameAndSizeText").opacity(0.5)
                    }
                    Spacer()
                   
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency).font(    .title).fontWeight(.bold)
                }
                
                VStack(spacing: 20) {
                    Button("Edit Order") {
                        isPresented = true
                        // Edit action
                    }
                    
                    Button("Delete order", role: .destructive) {
                        Task {
                            if ((orderId ?? 0) != 0) {
                                await coffeeModel.deleteOrder(orderId: orderId ?? 0)
                                dismiss()
                            }
                        }
                    }
                    

                }
                .frame(maxWidth: .infinity, alignment: .center)
                .sheet(isPresented: $isPresented) {
                    NavigationStack {
                        AddCoffeeView(order: order)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
}


#Preview {
    OrderViewDetail()
}
