//
//  DataService.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import Foundation

class DataService{
    static func getLocalData() -> [Recipe]{
        // Parse local json file
        
        // get url path
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // check if pathString is not nill, otherwise ...
        guard pathString != nil else{
            return [Recipe]()
        }
        
        
        // create url
        let url = URL(fileURLWithPath: pathString!)
        
        // create data object
        do{
            let data = try Data(contentsOf: url)
            
            // decode the data
            let decoder = JSONDecoder()
            do{
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // add unique ID
                for r in recipeData{
                    r.id = UUID()
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                return recipeData
                
            } catch{
                // error with parsing data
                print(error)
            }
            
            
            
            // return recipes
        } catch{
            // error with getting data
            print(error)
        }
        
        // return empty data if data is not available
        return [Recipe]()

    }
}
