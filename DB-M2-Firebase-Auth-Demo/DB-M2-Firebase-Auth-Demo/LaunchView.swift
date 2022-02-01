//
//  LaunchView.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import SwiftUI
import FirebaseEmailAuthUI


struct LaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    
    var body: some View {
        // check the logged in property and show the corresponding view
        if !loggedIn {
            Button {
                loginFormShowing = true
            }label:{
                Text("Sign In")
            }
            .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin){
                LoginForm()
            }
            .onAppear {
                checkLogin()
            }
        }
        else {
            // show logged in view
            ContentView(loggedIn: $loggedIn)
        }
    }
    
    func checkLogin(){
        loggedIn = FUIAuth.defaultAuthUI()?.auth?.currentUser == nil ? false : true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
