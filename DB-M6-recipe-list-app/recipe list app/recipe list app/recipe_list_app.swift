//
//  recipe_list_app.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
