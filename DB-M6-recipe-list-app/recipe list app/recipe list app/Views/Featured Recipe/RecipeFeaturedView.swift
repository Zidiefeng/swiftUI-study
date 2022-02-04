//
//  RecipeFeaturedView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 11/8/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // if create model here,
    // there would be two sets of dataset
    // not making any sense
    // should pass model here instead of creating one
    // @ObservedObject var model = RecipeModel()
    
    //    @EnvironmentObject var model: RecipeModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "featured == true")) var recipes: FetchedResults<Recipe>
    @State var isDetailViewShowing = false
    
    @State var tabSelectionIndex = 0
    
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top,40)
                .font(.largeTitle)
            //.font(Font.custom("Baskerville SemiBold", size: 40))
            
            
            GeometryReader{ geo in
                TabView(selection: $tabSelectionIndex) {
                    
                    //loop through each recipe
                    ForEach(0..<recipes.count){ index in
                        
                        // only show those that should be featured
                        //                        if recipes[index].featured {
                        
                        Button(action: {
                            // show the recipe detail sheet
                            self.isDetailViewShowing = true
                        }) {
                            //recipe card
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 0){
                                    let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipes[index].name)
                                        .padding(5)
                                }
                            }
                        }
                        .tag(index)
                        .sheet(isPresented: $isDetailViewShowing){
                            // show the Recipe Detail View
                            RecipeDetailView(recipe: recipes[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40,
                               height: geo.size.height - 100,
                               alignment: .center)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                        //                        }
                        
                    }
                    
                }
                //automatic, if only one, no dot
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: -5, y: 5)
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(" Preparation Time:")
                    .font(.headline)
                Text(recipes[tabSelectionIndex].prepTime)
                
                Text("Highlights")
                    .font(.headline)
                RecipeHighlights(highlights: recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading,.bottom])
        }
        // when the vstack is shown, the following code is performed
        .onAppear {
            setFeaturedIndex()
        }
        
        
    }
    
    
    func setFeaturedIndex(){
        // Find the index of the first recipe that is featured
        var index = recipes.firstIndex { recipe in
            print(recipe.featured)
            print(recipe.name)
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        // to enable preview, add environmentObject here
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
