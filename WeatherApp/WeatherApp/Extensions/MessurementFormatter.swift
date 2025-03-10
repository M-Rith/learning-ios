//
//  MessurementFormatter.swift
//  WeatherApp
//
//  Created by AppleD0g on 3/10/25.
//

import Foundation


extension MeasurementFormatter {
    
    static func temperature(value: Double, locale: Locale = .current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter
        formatter.locale = locale
        
        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)
        return formatter.string(from: temp)
    }
}
