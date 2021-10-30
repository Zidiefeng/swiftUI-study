//
//  ContentView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import SwiftUI

struct RecipeListView: View {
    
    // Reference to the view model
    @ObservedObject var model = RecipeModel()
    
    
    var body: some View {
        NavigationView {
            List(model.recipes){r in
                
                NavigationLink(
                    destination: RecipeDetailView(recipe: r),
                    label: {
                            // MARK: Row item
                            HStack(alignment: .center, spacing: 20.0){
                                
                                Image(r.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50,
                                           height: 50,
                                           alignment: .center)
                                    .clipped()
                                    .cornerRadius(5)

                                Text(r.name)
                                
                            }}
                )

            }.navigationBarTitle("Recipes")
        }
        
  
//        ScrollView{
//            VStack(alignment: .leading){
//                ForEach(model.recipes){ r in
//                    HStack(alignment: .center, spacing: 20.0){
//                        Image(r.image)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 50,
//                                   height: 50,
//                                   alignment: .center)
//                            .clipped()
//                            .cornerRadius(5)
//
//                        Text(r.name)
//                    }
//                }
//            }
//        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
