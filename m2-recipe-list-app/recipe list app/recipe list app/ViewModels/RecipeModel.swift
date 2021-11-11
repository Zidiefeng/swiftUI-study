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
    
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings:Int) -> String{
        
        var portion = ""
        var numerator = ingredient.num ?? 1 // if it's nil, it will take 1 instead
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            // Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            
            // Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            
            
            // Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            // Get the whole portion if numerator > denominator
            if numerator >= denominator{
                // calculated whole portions
                wholePortions = numerator / denominator
                
                //calculate the remainder
                numerator = numerator % denominator // modulo - remainder
                
                //Assign to portion string
                portion += String(wholePortions)
            }
            
            // express the remainder as a fraction
            if numerator > 0 {
                // Assign remainder as a fraction
                portion += wholePortions > 0 ? " " : ""
                
                portion += "\(numerator)/\(denominator)"
            }
        }
        if var unit = ingredient.unit {
            // calculate appropriate suffix

            
            if wholePortions > 1 {
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else{
                    unit += "s"
                }
            }

            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
        }
        
        // Express the remaindar
        return portion
    }
    
    
}
