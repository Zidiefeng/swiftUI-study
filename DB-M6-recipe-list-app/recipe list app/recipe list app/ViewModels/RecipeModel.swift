//
//  RecipeModel.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/23/21.
//

import Foundation
import UIKit


class RecipeModel: ObservableObject{
    @Published var recipes = [Recipe]()
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    init(){
        // Parse the json file
//        let service = DataService()
//        self.recipes = service.getLocalData()
        
        // when using `static`, the function of a class can be directlly called without instance
//        self.recipes = DataService.getLocalData()
        
        
        // set the recipes property
        
        // Check if we have preloaded the data into core data
        checkLoadedData()
    }
    
    func checkLoadedData() {
        // check local storage for the flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        
        // if it is false, we should parse the local json and preload into core data
        if status == false {
            preloadLocalData()
        }
    }
    
    func preloadLocalData(){
        // prase the local JSON file
        let localRecipes = DataService.getLocalData()
        
        // create core data objects
        for r in localRecipes {
            // create a core data object
            let recipe = Recipe(context: managedObjectContext)
            
            // Set its properties
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            recipe.id = UUID()
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            // set the ingredients
            for i in r.ingredients {
                // create a core data ingredient object
                let ingredient = Ingredient(context: managedObjectContext)
                
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.num = i.num ?? 1
                ingredient.denom = i.denom ?? 1
                
                // add to recipe
                recipe.addToIngredients(ingredient)
            }
            
        }
        
        // save into core data
        do{
            try managedObjectContext.save()
            
            // set local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        }
        catch{
            
        }
        
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
