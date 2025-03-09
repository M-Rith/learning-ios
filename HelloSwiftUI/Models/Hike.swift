//
//  Hike.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/9/25.
//

import Foundation

struct Hike: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let photo: String
    let miles: Double
}
