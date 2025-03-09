//
//  HikeDetailScreen.swift
//  HikingApp
//
//  Created by AppleD0g on 3/9/25.
//

import SwiftUI
struct HikeDetailScreen: View {
    let hike: Hike
    
    @State private var   zoomed: Bool = false
    var body: some View {
        VStack {
            Image(hike.photo).resizable().aspectRatio(contentMode: zoomed ? .fill : .fit).onTapGesture {
                zoomed.toggle()
            }
            Text(hike.name).font(.title)
            Text("\(hike.miles.formatted()) miles")
            Spacer()
        }.navigationTitle(hike.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HikeDetailScreen(hike:  Hike(name: "Salmonberry Trail", photo: "sal", miles: 6))
    }
   
}
