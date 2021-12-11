//
//  m6_city_sights_appApp.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/9/21.
//

import SwiftUI

@main
struct m6_city_sights_app: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
