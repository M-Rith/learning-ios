//
//  HelloSwiftUIApp.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/7/25.
//

import SwiftUI

@main
struct HelloSwiftUIApp: App {
    
//    @StateObject private var appState = AppState()
    @State private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView().environment(appState)
            }
        
        }
    }
}
