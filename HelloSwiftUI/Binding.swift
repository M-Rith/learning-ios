//
//  Binding.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/9/25.
//

import SwiftUI
import Observation
// Enviroment object
@Observable
class AppState {
    var isOn: Bool = false
}

struct LightBulbView: View {
  
//    @Binding var isOn: Bool
//    @Environment(AppState.self) private var appState: AppState
    
    @Environment(AppState.self) private var appState: AppState
    var body: some View {
        
        @Bindable var appState = appState
        
        VStack {
            Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb").font(.largeTitle).foregroundColor(appState.isOn ? .yellow: .black)
        }
//        Button("Toggle") {
//            appState.isOn.toggle()
//        }
        
        Toggle("IsOn", isOn: $appState.isOn)
    }
}

//struct LightRoomView: View {
//    @Binding var isOn : Bool
//    var body: some View {
//        var body: some View {
//            LightBulbView(isOn: $isOn)
//        }
//    }
//}
struct LightRoomView: View {
//    @Binding var isOn : Bool
    
    
    
    var body: some View {
//        LightBulbView(isOn: $isOn)
        
        LightBulbView()
    }
}




struct BindingView: View {
//    @State private var isLightOn: Bool = false
    
//    @Enviroment(AppState.self) private var appState: AppState
    @Environment(AppState.self) private var appState: AppState
    var body: some View {
        VStack {
//            LightBulbView(isOn: $isLightOn)
            LightBulbView()
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(appState.isOn ? .black : .white )
    }

}

#Preview {
    BindingView().environment(AppState())
}
