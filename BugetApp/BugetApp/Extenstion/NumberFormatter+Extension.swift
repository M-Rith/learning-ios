//
//  NumberFormatter+Extension.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//

import Foundation



extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2 
        return formatter
    }
}
