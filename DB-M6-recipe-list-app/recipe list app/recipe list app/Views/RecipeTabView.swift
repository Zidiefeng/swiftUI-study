//
//  RecipeTabView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/30/21.
//

import SwiftUI

struct RecipeTabView: View {
    
    @State var tabSelection = Constants.featuredTab
    
    var body: some View {
        
        // put view inside and eath assigned to a tab
        TabView(selection: $tabSelection) {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack{
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
                .tag(Constants.featuredTab)
            
            
            RecipeListView()
                .tabItem{
                    VStack{
                        // search SF Pro Text to check default icon name
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
                .tag(Constants.listTab)
            
            AddRecipeView(tabSelection: $tabSelection)
                .tabItem {
                    VStack{
                        Image(systemName: "plus.circle")
                        Text("Add")
                    }
                }
                .tag(Constants.addRecipeTab)
            
        }
        .environmentObject(RecipeModel())
        
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
