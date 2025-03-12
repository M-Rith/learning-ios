//
//  AppEnviroment.swift
//  CoffeeOrderApp
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me/")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me/")!
        }
    }
}

class AppEnvironmentManager {
    static let shared = AppEnvironmentManager()
    
    private init() {}
    
    var currentEnvironment: AppEnvironment {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .dev
        }
        return env == "TEST" ? .test : .dev
    }
    
    var baseURL: URL {
        return currentEnvironment.baseURL
    }
}


enum Endpoints {
    case allOrder
    case placeOrder
    
    var path: String {
        switch self {
        case .allOrder:
            return "/test/orders"
        case .placeOrder: return "/test/new-order"
        }
    }
}
