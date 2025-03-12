//
//  AddCoffeeView.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI

struct AddCoffeeView: View {
    
    @State private var name : String = ""
    @State private var coffeeName : String = ""
    @State private var price : String = ""
    @State private var coffeeSize : CoffeeSize = .medium
    var body: some View {
        Form {
            TextField("Name", text: $name).accessibilityIdentifier("name")
            TextField("Coffee Name", text: $coffeeName).accessibilityIdentifier("coffeeName")
            TextField("Price", text: $price).accessibilityIdentifier("price")
            
            Picker("Select size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue).tag(size)
                }
            }.pickerStyle(.segmented).padding(.vertical)
            
            
            Button("Place Order") {
                
            }.accessibilityIdentifier("placeOrder")
        }
    }
}

#Preview {
    AddCoffeeView()
}
