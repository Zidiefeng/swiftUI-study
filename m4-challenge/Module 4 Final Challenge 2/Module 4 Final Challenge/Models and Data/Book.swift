//
//  Book.swift
//  Module 4 Final Challenge
//
//  Created by Micah Beech on 2021-03-25.
//

import Foundation

struct Book : Decodable, Identifiable {
    
    var id = 1
    var title = "Title"
    var author = "Author"
    var content = ["I am a test book."]
    var isFavourite = false
    var rating = 2
    var currentPage = 0
    
}
