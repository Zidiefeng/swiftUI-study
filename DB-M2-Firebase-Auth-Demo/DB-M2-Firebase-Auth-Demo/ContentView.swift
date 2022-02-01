//
//  ContentView.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import SwiftUI
import FirebaseEmailAuthUI
struct ContentView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack{
            Text("Welcome")
            Button{
                try! FUIAuth.defaultAuthUI()?.signOut()
                loggedIn = false
            } label: {
                Text("Sign Out")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(true))
    }
}
