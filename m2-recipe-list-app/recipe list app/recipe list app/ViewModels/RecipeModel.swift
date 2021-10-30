//
//  RecipeModel.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import Foundation

class RecipeModel: ObservableObject{
    @Published var recipes = [Recipe]()
    
    init(){
        // Parse the json file
//        let service = DataService()
//        self.recipes = service.getLocalData()
        
        // when using `static`, the function of a class can be directlly called without instance
        self.recipes = DataService.getLocalData()
        
        
        // set the recipes property
    }
    
}
