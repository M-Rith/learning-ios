//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/7/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("costa-rica").resizable().aspectRatio(contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/.foregroundStyle(.red).font(.largeTitle)
            Text("Hello world").foregroundStyle(.blue).font(.title3).fontWeight(.heavy)
            
            HStack(spacing: 10) {
                Text("Left")
                Text("Right")
            }
            Text("I am Huot Monirith").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(25)
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1734542021536-7cfb64642277?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")) { image in
                image.resizable().padding()
            } placeholder: {
                ProgressView()
            }
            
        }.foregroundColor(.yellow).padding([.top, .bottom], 25)
        
    }
}

#Preview {
    ContentView()
}
