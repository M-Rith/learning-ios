//
//  StoreModel.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/11/25.
//

import Foundation

class StoreModel : ObservableObject {
    
    @Published var products : [Product] = []
    
    
    func populateProduct() async {
        
    }
}
