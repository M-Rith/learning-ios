////
////  ContentView.swift
////  Hiking
////
////  Created by Mohammad Azam on 9/25/23.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    let hikes = [
//        Hike(name: "Salmonberry Trail", photo: "sal", miles: 6),
//        Hike(name: "Tom, Dick, and Harry Mountain", photo: "tom", miles: 5.8),
//        Hike(name: "Tamanawas Falls", photo: "tam", miles: 5)
//    ]
//    
//    var body: some View {
//        List(hikes) { hike in
//            HStack(alignment: .top) {
//                Image(hike.photo)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
//                    .frame(width: 100)
//                   
//                VStack(alignment: .leading) {
//                    Text(hike.name)
//                    Text("\(hike.miles.formatted()) miles")
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//
//let hikes = [
//    Hike(name: "Salmonberry Trail", photo: "sal", miles: 6),
//    Hike(name: "Tom Dick and arry Mountain", photo: "tom", miles: 5.8),
//    Hike(name: "Tamnawas Falls", photo: "tam", miles: 5)
//]
//var body: some View {
//    NavigationStack {
//        List(hikes) { hike in
//            NavigationLink(value: hike) {
//                HikeListView(hike: hike)
//            }
//        }
//        .navigationTitle("Mountains")
//        .navigationDestination(for: Hike.self) { hike in
//            HikeDetailScreen(hike: hike)
//        }
//    }
//}
//}
//
//#Preview {
//hiking()
//}
//
//struct HikeListView : View {
//let hike: Hike
//var body: some View {
//    HStack(alignment: .center) {
//        Image(hike.photo)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//            .frame(width: 100)
//        
//        VStack(alignment: .leading){
//            Text(hike.name)
//            Text("\(hike.miles.formatted()) miles").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//        }
//    }
//}
//}


//
//  hiking.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/9/25.
//

import SwiftUI

struct ContentView: View {
    
    
    let hikes = [
        Hike(name: "Salmonberry Trail", photo: "sal", miles: 6),
        Hike(name: "Tom Dick and arry Mountain", photo: "tom", miles: 5.8),
        Hike(name: "Tamnawas Falls", photo: "tam", miles: 5)
    ]
    var body: some View {
        NavigationStack {
            List(hikes) { hike in
                NavigationLink(value: hike) {
                    HikeListView(hike: hike)
                }
            }
            .navigationTitle("Mountains")
            .navigationDestination(for: Hike.self) { hike in
                HikeDetailScreen(hike: hike)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct HikeListView : View {
    let hike: Hike
    var body: some View {
        HStack(alignment: .center) {
            Image(hike.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .frame(width: 100)
            
            VStack(alignment: .leading){
                Text(hike.name)
                Text("\(hike.miles.formatted()) miles").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
    }
}
