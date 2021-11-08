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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
    }
}
