//
//  ContentView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import SwiftUI

struct RecipeListView: View {
    
    // Reference to the view model
    // comment this, use environment object method instead
    // @ObservedObject var model = RecipeModel()
    
    
    // use the environment object passed from the parent viewe
    @EnvironmentObject var model: RecipeModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.top,40)
                    .font(.largeTitle)
                
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.recipes){r in
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
                                            VStack(alignment: .leading) {
                                                Text(r.name)
                                                    .foregroundColor(.black)
                                                    .bold()
                                                RecipeHighlights(highlights: r.highlights)
                                                    .foregroundColor(.black)
                                            }
                                        }}
                            )
                        }
                    }

                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
            // to align with the featuredView
            //.navigationBarTitle("Recipes")
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
            .environmentObject(RecipeModel())
    }
}
