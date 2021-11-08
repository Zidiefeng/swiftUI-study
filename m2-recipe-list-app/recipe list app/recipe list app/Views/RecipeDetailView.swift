//
//  RecipeDetailView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/24/21.
//

import SwiftUI

struct RecipeDetailView: View {
    // since this is unset, it's need to be passed when create this view
    var recipe: Recipe
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                // MARK: Integredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical,5)
                    //for identifiable object, ingredient, no id is needed! /*id: \.self*/
                    ForEach(recipe.ingredients){item in
                        Text("• "+item.name)
                            .padding(.bottom, 1)
                    }
                }
                .padding(.horizontal)
                
                // MARK: Divider
                Divider()
                
                // MARK: Directions
                VStack(alignment: .leading){
                    Text("Directions")
                        .font(.headline)
                        .padding(.vertical,5)
                    ForEach(0..<recipe.directions.count,id: \.self){i in
                        Text(String(i+1)+". " + recipe.directions[i])
                            .padding(.bottom, 6)
                    }
                }
                .padding(.horizontal)
                
            }
        }
        .navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Create a dummy recipe and pass it into the detail view so that we can see a preview
        let model = RecipeModel()
        
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
