//
//  NumberFormatter.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter() // ✅ Fixed typo
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD" // ✅ Default currency (change as needed)
        return formatter
    }
}
