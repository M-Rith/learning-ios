//
//  Date+Extension.swift
//  BugetApp
//
//  Created by AppleD0g on 3/16/25.
//

import Foundation


extension Date {
 
    
    func formattedString(format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
