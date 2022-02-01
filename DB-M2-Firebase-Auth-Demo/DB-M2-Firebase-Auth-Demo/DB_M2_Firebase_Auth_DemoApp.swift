//
//  DB_M2_Firebase_Auth_DemoApp.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import SwiftUI
import Firebase

@main
struct DB_M2_Firebase_Auth_DemoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
    }
}
