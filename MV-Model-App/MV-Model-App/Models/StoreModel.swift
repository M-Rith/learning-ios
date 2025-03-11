//
//  StoreModel.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/11/25.
//

import Foundation

class StoreModel : ObservableObject {
    
    @Published var products : [Product] = []
    
    let webService : Webservice
    
    
    init(webService: Webservice) {
        self.webService = webService
    }
    
    func populateProduct() async throws {
        products = try await webService.getProducts()
        
        
    }
}
