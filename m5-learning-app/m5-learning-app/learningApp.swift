//
//  m5_learning_appApp.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import SwiftUI

@main
struct learningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .self.environmentObject(ContentModel())
//            HomeView1()
//            LearnNavigationLink()
        }
    }
}
