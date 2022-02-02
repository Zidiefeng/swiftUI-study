//
//  ContentView.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
struct ContentView: View {
    
    @Binding var loggedIn: Bool
    @State private var firstname: String = ""
    var body: some View {
        VStack(spacing: 20){
            Text("Welcome")
            
            TextField("name", text: $firstname)
            
            Button {
                saveFirstName()
            } label: {
                Text("Save")
            }

            
            Button{
                try! Auth.auth().signOut()
                loggedIn = false
            } label: {
                Text("Sign Out")
            }
        }
    }
    
    func saveFirstName(){
        if let currentUser = Auth.auth().currentUser{
            let cleansedFirstName = firstname.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            let path = db.collection("users").document(currentUser.uid)
            path.setData(["firstname":cleansedFirstName]) {error in
                if error == nil{
                    //Saved
                    
                }
                else{
                    
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(true))
    }
}
