//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by AppleD0g on 3/10/25.
//

import Foundation


enum APIEndpoint {
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinatesByLocationName(String)
    case weatherByLatLon(Double, Double)
    
    private var path: String {
        switch self {
        case .coordinatesByLocationName(let city) :
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.weatherAPIKey)"
        case .weatherByLatLon(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.weatherAPIKey)"
        }
    }
    
    static func endPointURL (for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path;
        
        return URL(string: baseURL + endpointPath)!
    }
}
