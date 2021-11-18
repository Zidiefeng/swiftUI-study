//
//  Module_4_Final_ChallengeApp.swift
//  Module 4 Final Challenge
//
//  Created by Micah Beech on 2021-03-25.
//

import SwiftUI

@main
struct Module_4_Final_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            BookList()
                .environmentObject(ViewModel())
        }
    }
}
