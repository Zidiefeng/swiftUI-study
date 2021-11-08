//
//  RecipeFeaturedView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 11/8/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    // if create model here,
    // there would be two sets of dataset
    // not making any sense
    // should pass model here instead of creating one
    // @ObservedObject var model = RecipeModel()
    
    @EnvironmentObject var model: RecipeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top,40)
                .font(.largeTitle)
            GeometryReader{ geo in
                TabView {
                    
                    //loop through each recipe
                    ForEach(0..<model.recipes.count){ index in
                        
                        // only show those that should be featured
                        if model.recipes[index].featured {
                            
                            //recipe card
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    
                                VStack(spacing: 0){
                                    Image(model.recipes[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(model.recipes[index].name)
                                        .padding(5)
                                }
                            }.frame(width: geo.size.width - 40,
                                    height: geo.size.height - 100,
                                    alignment: .center)
                             .cornerRadius(25)
                             .shadow(radius: 10)
                            
                        }
                        
                    }
                    
                }
                //automatic, if only one, no dot
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: -5, y: 5)
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(" Preparation Time:")
                    .font(.headline)
                Text("1 hour")
                
                Text("Highlights")
                    .font(.headline)
                Text("Healthy, Hearty")
            }
            .padding([.leading,.bottom])
        }
        

    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        // to enable preview, add environmentObject here
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
