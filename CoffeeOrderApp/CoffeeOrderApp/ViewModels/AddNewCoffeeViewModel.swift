////
////  AddNewCoffeeViewModel.swift
////  CoffeeOrderApp
////
////  Created by AppleD0g on 3/12/25.
////
//
import Foundation
import Observation


@Observable class AddCoffeeError {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}


@Observable class AddNewCoffeeViewModel {
    
    
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
    var coffeeSize: CoffeeSize = .medium
    var errors = AddCoffeeError()
    
    var isValid: Bool {
        validate()
    }
    
    
    var selectedOrder: Order = Order(id: 0, name: "", coffeeName: "", total: 0.0, size: .medium)
    var isEditing: Bool = false
    
    
    func loadOrder(_ existingOrder: Order?) {
        if let existingOrder = existingOrder {
            self.selectedOrder = existingOrder
            self.isEditing = true
            
            self.name = existingOrder.name
            self.coffeeName = existingOrder.coffeeName
            self.coffeeSize = existingOrder.size
            self.price = String(existingOrder.total)
        }
    }
    

    func validate() -> Bool {
        errors.name = ""
        errors.coffeeName = ""
        errors.price = ""
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            errors.name = "Name cannot be empty!"
        }
        
        if coffeeName.trimmingCharacters(in: .whitespaces).isEmpty {
            errors.coffeeName = "Coffee name cannot be empty!"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty!"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number"
        } else if Double(price) ?? 0 < 1 {
            errors.price = "Price needs to be more than 0"
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }
    
    func saveOrUpdate() async {
        let orderItem = Order(
            id: selectedOrder.id,
            name: name,
            coffeeName: coffeeName,
            total: Double(price) ?? 0,
            size: coffeeSize
        )
        
        if isEditing {
            guard let orderId = selectedOrder.id else {
                return
            }

            do {
                let updatedOrder: Order = try await WebService().update(endpoint: "orders/\(orderId)", body: orderItem)

                if let index = CoffeeViewModel.shared.orders.firstIndex(where: { $0.id == orderId }) {
                    CoffeeViewModel.shared.orders[index] = updatedOrder
                }
            } catch {
                print("❌ Failed to update order:", error.localizedDescription)
            }
        } else {
            do {
                let createdOrder: Order = try await WebService().post(endpoint: "newOrder", body: orderItem)
                CoffeeViewModel.shared.orders.append(createdOrder)
            } catch {
                print("❌ Failed to create order:", error.localizedDescription)
            }
        }
    }
    
}
