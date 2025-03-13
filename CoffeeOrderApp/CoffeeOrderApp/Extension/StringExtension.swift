//
//  StringExtension.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation


extension String {
    
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    
    func isLessThan(_ number: Double) -> Bool {
        if !self.isNumeric {
            return false
        }
        guard let value = Double(self) else {return false}
        return value < number
    }
    
}
