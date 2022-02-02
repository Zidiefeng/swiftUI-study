//
//  SwiftUI_DB_M5_Core_Data_DemoApp.swift
//  SwiftUI-DB-M5-Core-Data-Demo
//
//  Created by 孙恺檀 on 1/14/22.
//

import SwiftUI

@main
struct SwiftUI_DB_M5_Core_Data_DemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
