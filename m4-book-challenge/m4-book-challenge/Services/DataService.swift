//
//  DataService.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import Foundation

class DataService{
    static func getLocalData() -> [Book]{
        // Parse local json file
        
        // get url path
        let pathString = Bundle.main.path(forResource: "Data", ofType: "json")
        
        // check if pathString is not nill, otherwise ...
        guard pathString != nil else{
            return [Book]()
        }
        
        
        // create url
        let url = URL(fileURLWithPath: pathString!)
        
        // create data object
        do{
            let data = try Data(contentsOf: url)
            
            // decode the data
            let decoder = JSONDecoder()
            do{
                let bookData = try decoder.decode([Book].self, from: data)
                
                // add unique ID
//                for book in bookData{
//                    book.id = UUID()
//                }
                return bookData
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
        return [Book]()

    }
}
