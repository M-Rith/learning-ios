//
//  AddCoffeeView.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI

struct AddCoffeeView: View {
    @State private var viewModel = AddNewCoffeeViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var order: Order?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $viewModel.name)
                    .accessibilityIdentifier("name")
                Text(viewModel.errors.name)
                    .foregroundColor(.red)
                    .font(.caption)
                    .visible(!viewModel.errors.name.isEmpty)

                TextField("Coffee Name", text: $viewModel.coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(viewModel.errors.coffeeName)
                    .foregroundColor(.red)
                    .font(.caption)
                    .visible(!viewModel.errors.coffeeName.isEmpty)

                TextField("Price", text: $viewModel.price)
                    .accessibilityIdentifier("price")
                Text(viewModel.errors.price)
                    .foregroundColor(.red)
                    .font(.caption)
                    .visible(!viewModel.errors.price.isEmpty)

                Picker("Select size", selection: $viewModel.coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)

                Button(order?.id != nil ? "Update Order" : "Place Order") { // ✅ Safe unwrapping
                    if viewModel.validate() {
                        Task {
                            await viewModel.saveOrUpdate()
                            dismiss()
                        }
                    }
                }
                .accessibilityIdentifier(order?.id != nil ? "edit" : "placeOrder") // ✅ Safe unwrapping
                .centerHorizontally()
            }
            .navigationTitle(order?.id != nil ? "Edit Coffee" : "Add New Coffee") // ✅ Safe unwrapping
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadOrder(order)
            }
        }
    }
}

#Preview {
    NavigationStack { 
        AddCoffeeView()
    }
}
