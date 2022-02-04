//
//  ImagePicker.swift
//  recipe list app
//
//  Created by 孙恺檀 on 2/3/22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    // every UIViewController has a presentation mode that we can dismiss itself
    @Environment(\.presentationMode) var presentationMode
    
    var selectedSource: UIImagePickerController.SourceType
    
    // optional since the user does not necessarily need to select a image
    @Binding var recipeImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // create the image picker controller
        let imagePickerControler = UIImagePickerController()
        
        // Set the delegate
        // Create the coordinator or access an existing coordinator
        // If there is no coordinator, it will call `makeCoordinator` to create one
        imagePickerControler.delegate = context.coordinator
        
        //check this source is available or not
        if UIImagePickerController.isSourceTypeAvailable(selectedSource){
            // set the image picker source to album
            //UIImagePickerController.SourceType.photoLibrary
            // .photoLibrary
            imagePickerControler.sourceType = selectedSource
        }
        
        return imagePickerControler
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        // create a coordinator
        Coordinator(parent: self)
    }
    
    // UIImagePickerController: this class will implement methods to handle events from image picker
    // Since UIImagePickerController is a type of UINavigationController, to navigate different views, it need to conform to UINavigationControllerDelegate as well
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        // need to access some properties of the parent (ImagePicker)
        var parent: ImagePicker
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        // info is a directionary that contains a key and a value (the selected image)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // check if we can get the image
            // UIImagePickerController.InfoKey.originalImage is the key to get the original image
            // This image is in UIImage format
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                // we were able to get the uiimage into the image constant
                // pass this back to the AddRecipeView using the binding relationship
                parent.recipeImage = image
            }
            
            // dismiss this view
            // wrappedValue: the underlying value referenced by the binding variable
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
