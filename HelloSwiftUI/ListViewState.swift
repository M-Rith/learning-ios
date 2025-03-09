//
//  ListViewState.swift
//  HelloSwiftUI
//
//  Created by AppleD0g on 3/9/25.
//

import SwiftUI

struct ListViewState: View {
    
    @State private var name : String = ""
    @State private var friends : [String] = []
    
    var body: some View {
        VStack {
            TextField("Enter your name" , text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    friends.append(name)
                    name=""
                }
            
            List(friends, id: \.self) { friend in
                Text(friend)
            }
            
            
            Spacer()
        }.padding()
    }
}

#Preview {
    ListViewState()
}
