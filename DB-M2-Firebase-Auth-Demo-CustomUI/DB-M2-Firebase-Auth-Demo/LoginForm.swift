//
//  LoginForm.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    @Binding var formShowing: Bool
    
    var body: some View {
        NavigationView{
            Form{
            
                Section{
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                Button {
                    // Perform login
                    signIn()
                } label: {
                    HStack{
                        Spacer()
                        Text("Sign In")
                        Spacer()
                    }
                }

            }
            .navigationBarTitle("Sign In")
        }
        
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if error == nil {
                    // dismiss this sheet
                    formShowing = false
                }
                else{
                    // if there is an issue with logging in
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(formShowing: Binding.constant(true))
    }
}
