//
//  Weather.swift
//  WeatherApp
//
//  Created by AppleD0g on 3/10/25.
//

import Foundation

struct WeatherResponse : Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
}
