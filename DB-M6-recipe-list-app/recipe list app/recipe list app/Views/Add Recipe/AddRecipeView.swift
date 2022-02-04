//
//  AddRecipeView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 2/3/22.
//

import SwiftUI

struct AddRecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Properties for recipe meta data
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    // List type recipe meta data
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    // ingredient data
    @State private var ingredients = [IngredientJSON]()
    
    // Image picker
    @State private var isShowingImagePicker = false
    // optional because user does not need to add image
    // pass as binding variable to the image picker
    @State private var recipeImage: UIImage?
    @State private var placeHolderImage = Image("noImageAvailable")
    @State private var selectedImageSource = UIImagePickerController.SourceType.photoLibrary

    // tab selection
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            // HStack with the form controls
            HStack {
                Button("Clear") {
                    // Clear the form
                    clear()
                }
                
                Spacer()
                
                Button("Add") {
                    // Add the recipe to core data
                    addRecipe()
                    
                    // Clear the form
                    clear()
                    
                    // Navigate to the list
                    tabSelection = 1
                }
            }
            
            // Recipe image
            placeHolderImage
                .resizable()
                .scaledToFit()
            
            HStack{
                Button("Photo Library"){
                    selectedImageSource = .photoLibrary
                    isShowingImagePicker = true
                }
                
                Text(" | ")
                
                Button("Camera"){
                    selectedImageSource = .camera
                    isShowingImagePicker = true
                }
            }
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedSource: selectedImageSource,recipeImage: $recipeImage)
            }
            

            
            ScrollView(showsIndicators: false) {
                VStack{
                    // The recipe meta data
                    AddMetaData(name: $name,
                                summary: $summary,
                                prepTime: $prepTime,
                                cookTime: $cookTime,
                                totalTime: $totalTime,
                                servings: $servings)
                    
                    // List data
                    AddListData(list: $highlights, title: "Highlights", placeholderText: "Any highlight?")
                    AddListData(list: $directions, title: "Directions", placeholderText: "Any direction?")
                    
                    // ingredient data
                    AddIngredientData(ingredients: $ingredients)
                }
            }
            
        }
        .padding()
    }
    
    func loadImage(){
        // check if an image was selected from the library
        if recipeImage != nil {
            // set it as the placeholder image
            placeHolderImage = Image(uiImage: recipeImage!)
        }
        
    }
    
    func addRecipe(){
        // add the recipe into core data
        let recipe = Recipe(context: viewContext)
        recipe.id = UUID()
        recipe.name = name
        recipe.cookTime = cookTime
        recipe.prepTime = prepTime
        recipe.totalTime = totalTime
        recipe.servings = Int(servings) ?? 1
        recipe.directions = directions
        recipe.highlights = highlights
        
        // .image in core data is binary data
        // recipeImage is UIImage
        // we can use .pngData() to do the transformation
        recipe.image = recipeImage?.pngData()
        
        // Add the ingredients
        for i in ingredients {
            let ingredient = Ingredient(context: viewContext)
            ingredient.id = UUID()
            ingredient.name = i.name
            ingredient.unit = i.unit
            ingredient.num = i.num ?? 1
            ingredient.denom = i.denom ?? 1
            
            // Add this ingredient to the recipe
            recipe.addToIngredients(ingredient)
        }
        
        // save to core data
        do{
            try viewContext.save()
            
            //switch the view to the list view
        }
        catch{
            // could not save the recipe
        }
    }
    
    
    func clear(){
        // Clear all the form fields
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        
        highlights = [String]()
        directions = [String]()
        
        ingredients = [IngredientJSON]()

        placeHolderImage = Image("noImageAvailable")    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(tabSelection: Binding.constant(1))
    }
}
