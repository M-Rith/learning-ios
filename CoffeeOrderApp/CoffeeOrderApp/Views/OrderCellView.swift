//
//  OrderCellView.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI

struct OrderCellView: View {
    let order: Order
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).accessibilityIdentifier("OrderNameText").bold()
                
                Text("\(order.coffeeName) (\(order.size.rawValue))").accessibilityIdentifier("CoffeeNameAndSizeText").opacity(0.5)
                
            }
            Spacer()
            Text(order.total, format: .currency(code: "USD")) // ✅ SwiftUI
                .accessibilityIdentifier("CoffeePriceText")
        }
    }
}
