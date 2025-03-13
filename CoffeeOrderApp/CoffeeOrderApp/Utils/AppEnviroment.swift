//
//  AppEnviroment.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation


@Observable
class AppEnvironment {
    var baseURL: String
    
    /// Singleton instance
    static let shared = AppEnvironment(baseURL: "https://island-bramble.glitch.me/")
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
}
