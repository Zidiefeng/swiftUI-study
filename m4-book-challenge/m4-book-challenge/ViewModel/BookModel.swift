//
//  BookModel.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import Foundation
import SwiftUI

class BookModel: ObservableObject{

    @Published var books: [Book]
    init(){
        self.books = DataService.getLocalData()
    }
}
