//
//  ContentModel.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules: [Module] = [Module]()
    
    var styleData : Data?
    
    init() {
        self.getLocalData()
    }
    
    func getLocalData(){
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            //use `.self` to pass the type
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //assign modules to var
            self.modules = modules
        }
        catch{
            // log error
            print("Could not parse local data")
        }
        
        
        // parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch{
            // log error
            print("Could not parse style data")
        }
        
        
        
    }
}

