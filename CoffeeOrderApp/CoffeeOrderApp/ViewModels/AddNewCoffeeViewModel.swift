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

@Observable
class AddNewCoffeeViewModel {
    
    
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
    var coffeeSize: CoffeeSize = .medium
    var errors = AddCoffeeError()
    
    var isValid: Bool {
        validate()
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
    
    func postNewOrder() async {
        let newOrder = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
        
        do {
            let createdOrder: Order = try await WebService().post(endpoint: "newOrder", body: newOrder)
            CoffeeViewModel.shared.orders.append(createdOrder)
        } catch {
            print("Failed to create order: \(error.localizedDescription)")
        }
    }
}
