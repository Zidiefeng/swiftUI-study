//
//  CreateForm.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 2/1/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
struct CreateForm: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    @Binding var formShowing: Bool
    
    
    var body: some View {
    NavigationView{
        Form{
            Section{
                TextField("Email", text: $email)
                TextField("Name", text: $name)
                SecureField("Password", text: $password)
            }
            
            if errorMessage != nil {
                Section {
                    Text(errorMessage!)
                }
            }
            
            Button {
                // Create Account
                createAccount()
            } label: {
                HStack{
                    Spacer()
                    Text("Create Account")
                    Spacer()
                }
            }

        }
        .navigationBarTitle("")
    }
}
    
    func createAccount(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if error == nil {
                    saveName()
                    // Dismiss the form
                    formShowing = false
                }
                else {
                    errorMessage = error?.localizedDescription
                }
            }
        }
    }
    func saveName(){
        if let currentUser = Auth.auth().currentUser{
            let cleansedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            let path = db.collection("users").document(currentUser.uid)
            path.setData(["name":cleansedName]) {error in
                if error == nil{
                    //Saved
                    
                }
                else{
                    
                }
            }
        }

    }
}

struct CreateForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateForm(formShowing:  Binding.constant(true))
    }
}
