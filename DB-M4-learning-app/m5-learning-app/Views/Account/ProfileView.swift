//
//  ProfileView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 2/1/22.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        Button{
            //sign out the user
            try! Auth.auth().signOut()
            
            // change to logged out view
            model.checkLogin()
        } label: {
            Text("Sign Out")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
