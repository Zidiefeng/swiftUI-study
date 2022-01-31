//
//  JSONtoFirebaseApp.swift
//  JSONtoFirebase
//
//  Created by Micah Beech on 2020-10-23.
//

import SwiftUI
import Firebase

@main
struct JSONtoFirebaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(loader: FirebaseLoader())
        }
    }
}
