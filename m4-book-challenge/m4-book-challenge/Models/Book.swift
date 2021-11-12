//
//  Book.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import Foundation

class Book: Identifiable, Decodable{
    var title: String
    var author: String
    var isFavourite: Bool
    var currentPage: Int
    var rating: Int
    var id: Int
    var content: [String]
}
 
