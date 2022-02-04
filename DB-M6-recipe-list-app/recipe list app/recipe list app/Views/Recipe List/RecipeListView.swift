//
//  ContentView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Reference to the view model
    // comment this, use environment object method instead
    // @ObservedObject var model = RecipeModel()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var recipes: FetchedResults<Recipe>
    
    @State private var filterBy = ""
    private var filteredRecipes: [Recipe]{
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // no filter text, so return all recipes
            return Array(recipes)
        }
        else{
            // filter by the search term and return the corresponding subset
            return recipes.filter { recipe in
                return recipe.name.contains(filterBy)
            }
        }
    }
    
    // use the environment object passed from the parent viewe
    //@EnvironmentObject var model: RecipeModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.top,40)
                    .font(.largeTitle)
                
                SearchBarView(text: $filterBy)
                    .padding([.trailing, .bottom])
                
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(filteredRecipes){r in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: r),
                                label: {
                                        // MARK: Row item
                                        HStack(alignment: .center, spacing: 20.0){
                                            let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                            Image(uiImage: image)
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
            .onTapGesture {
                // resiign first responder
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            // to align with the featuredView
            //.navigationBarTitle("Recipes")
        }
        
//        ScrollView{
//            VStack(alignment: .leading){
//                ForEach(recipes){ r in
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
