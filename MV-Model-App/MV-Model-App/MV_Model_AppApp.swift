//
//  MV_Model_AppApp.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/11/25.
//

import SwiftUI

@main
struct MV_Model_AppApp: App {
    
    @StateObject private var storeModel = StoreModel(webService: Webservice())
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(storeModel)
        }
    }
}
