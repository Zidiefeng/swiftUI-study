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
    
    // Picker
    @State var selectedServingSize = 2
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                // MARK: Recipe title
                Text(recipe.name)
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading)
                    .font(.largeTitle)
                
                
                // MARK: Serving Size Picker
                VStack(alignment: .leading){
                    Text("Select Your Serving Size:")
                    Picker("", selection: $selectedServingSize){
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 160)
                }
                .padding()
                
                
                
                // MARK: Integredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical,5)
                    //for identifiable object, ingredient, no id is needed! /*id: \.self*/
                    ForEach(recipe.ingredients){item in
                        // no need to be binding here in selectedServingSize
                        Text("• " +
                             RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) +
                             " " +
                             item.name.lowercased())
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
        //.navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Create a dummy recipe and pass it into the detail view so that we can see a preview
        let model = RecipeModel()
        
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
