//
//  Business.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/11/21.
//

import Foundation

struct Business: Decodable{
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var is_closed: Bool?
    var url: String?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location:
}

struct Location: Decodable{
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
}

struct Category: Decodable{
    var alis: String?
    var title: String?
    
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
