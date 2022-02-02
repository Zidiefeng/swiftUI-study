//
//  LaunchView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 2/1/22.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.loggedIn == false {
            //show login view
            LoginView()
                .onAppear {
                    //check if the user is logged in or out
                    model.checkLogin()
                }
        }
        else {
            // show the logged in view
            TabView{
                HomeView()
                    .tabItem {
                        VStack{
                            Image(systemName: "book")
                            Text("Learn")
                        }
                    }
                ProfileView()
                    .tabItem {
                        VStack{
                            Image(systemName: "person")
                            Text("Learn")
                        }
                    }
            }
            .onAppear {
                model.getModules()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
