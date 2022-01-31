//
//  m5_learning_appApp.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import SwiftUI
import Firebase

@main
struct learningApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .self.environmentObject(ContentModel())
//            HomeView1()
//            LearnNavigationLink()
        }
    }
}
