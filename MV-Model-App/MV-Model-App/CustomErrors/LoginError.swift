//
//  LoginError.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/12/25.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    
    
    var errorDescription: String? {
        switch self {
            case .emailEmpty : return "Email cannot be empty!"
            case .emailInvalid: return "Email is not in correct format!"
            case .passwordEmpty: return "Password canoot be empty"
        }
    }
}
