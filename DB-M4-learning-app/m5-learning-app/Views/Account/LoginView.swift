//
//  LoginView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 2/1/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
struct LoginView: View {
    @EnvironmentObject var model: ContentModel
    
    // enum, like encoded int using categories
    @State var loginMode = Constants.LoginMode.login
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var errorMessage: String? = nil
    
    var buttonText: String {
        if loginMode == Constants.LoginMode.login{
            return "Login"
        }
        else{
            return "Sign Up"
        }
    }
    
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            
            // logo
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
            
            // title
            Text("Learnzilla")
            
            Spacer()
            
            //picker
            Picker(selection: $loginMode, label: Text("Hey")) {
                Text("Login")
                    .tag(Constants.LoginMode.login)
                
                Text("Sign up")
                    .tag(Constants.LoginMode.createAccount)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            //form
            // put things in a group since every container can only
            // contain <=10 components
            Group{
                TextField("Email", text: $email)
                    
                
                if loginMode == Constants.LoginMode.createAccount{
                    TextField("Name", text: $name)
                }
                SecureField("Password", text: $password)
                
                if errorMessage != nil {
                    Text(errorMessage!)
                }
            }
            
            //Button
            Button{
                if loginMode == Constants.LoginMode.login{
                    // log the user in
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        
                        // check for errors
                        guard error == nil else {
                            errorMessage = error!.localizedDescription
                            return
                        }
                        // clear the error message
                        self.errorMessage = nil
                        
                        // fetch the user meta data
                        model.getUserData()
                        
                        //change the view to logged in view
                        model.checkLogin()
                    }
                }
                else{
                    // create a new acount
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        guard error == nil else {
                            self.errorMessage = error!.localizedDescription
                            return
                        }
                        self.errorMessage = nil
                        
                        // save the first name
                        let firebaseUser = Auth.auth().currentUser
                        let db = Firestore.firestore()
                        let ref = db.collection("users").document(firebaseUser!.uid)
                        ref.setData(["name" : name], merge: true)

                        // update the user meta data
                        let user = UserService.shared.user
                        user.name = name
                        
                        // change the view to logged in view
                        model.checkLogin()
                    }
                }
            } label:{
                ZStack{
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 40)
                        .cornerRadius(10)
                    Text(buttonText)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal,40)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
