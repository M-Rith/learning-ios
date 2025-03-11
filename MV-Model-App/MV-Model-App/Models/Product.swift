//
//  Product.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/11/25.
//

import Foundation

struct Product : Decodable, Identifiable {
    let id: Int
    let title : String
    let price : Double
}
