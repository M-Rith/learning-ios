//
//  ListViewState.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/9/25.
//

import SwiftUI

struct ListViewState: View {
    
    @State private var name : String = ""
//    @State private var friends : [String] = []
    
    @State private var searchName: String = ""
    
    
    @State private var friends: [String] = ["John", "Mary", "Steven", "Steve", "Jerry"]
    @State private var filterFriends: [String] = []
    
    var body: some View {
//        VStack {
//            TextField("Enter your name" , text: $name)
//                .textFieldStyle(.roundedBorder)
//                .onSubmit {
//                    friends.append(name)
//                    name=""
//                }
//            
//            List(friends, id: \.self) { friend in
//                Text(friend)
//            }
//            
//            
//            Spacer()
//        }.padding()
        
        
        
        VStack {
            List(filterFriends, id: \.self) { friend in
                Text(friend)
            }
            .listStyle(.plain)
            .searchable(text: $searchName)
            .onChange(of: searchName) {
            
                
                if searchName.isEmpty {
                    filterFriends = friends
                }
                else {
                    filterFriends = friends.filter { $0.contains(searchName)}
                }
            }
            Spacer()
        }.padding()
        .onAppear(perform: {
            filterFriends = friends
        })
        .navigationTitle("Friends")
    }
}

#Preview {
    NavigationStack {
        ListViewState()
    }
}
