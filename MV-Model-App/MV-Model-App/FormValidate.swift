//
//  FormValidate.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/12/25.
//

import SwiftUI

struct LoginFormError {
    var email: String = ""
    var password: String = ""
}




struct FormValidate: View {
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var loginFormError = LoginFormError()
    
    var isFormValid: Bool {
        if email.isEmpty {
            loginFormError.email = "Email is required!"
        } else if !email.isValidEmail {
            loginFormError.email = "Email is not in correct format!"
        }
        
        
        if password.isEmpty {
            loginFormError.password = "Passwrod is required !"
        }
        
        return loginFormError.email.isEmpty && loginFormError.password.isEmpty
    }
    
    
    
    var body: some View {
        Form {
            TextField("Email", text: $email).textInputAutocapitalization(.never)
            if !loginFormError.email.isEmpty{
                Text(loginFormError.email).font(.caption).foregroundStyle(.red)
            }
            
            
            
            SecureField("Password", text: $password)
            if !loginFormError.password.isEmpty {
                Text(loginFormError.password).font(.caption).foregroundStyle(.red)
            }
           
            
            Button("Login") {
                if isFormValid {
                    // Submit the form
                }
                
            }.disabled(!isFormValid)
            
        }
    }
}

#Preview {
    FormValidate()
}
