//
//  RecipeTabView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/30/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        // put view inside and eath assigned to a tab
        TabView {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack{
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            
            RecipeListView()
                .tabItem{
                    VStack{
                        // search SF Pro Text to check default icon name
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
            
        }
        .environmentObject(RecipeModel())
        
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
