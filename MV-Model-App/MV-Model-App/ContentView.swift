//
//  ContentView.swift
//  MV-Model-App
//
//  Created by AppleD0g on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var storeModel : StoreModel
    
    
    private func getproducts() async {
        do {
            try await storeModel.populateProduct()
        } catch {
            print("Error")
        }
    }
    
    var body: some View {
        VStack {
            List(storeModel.products) { product in
                Text(product.title)
            }
        }.task {
            await getproducts()
        }
        .padding()
    }
}

#Preview {
    ContentView().environmentObject(StoreModel(webService: Webservice()))
}
