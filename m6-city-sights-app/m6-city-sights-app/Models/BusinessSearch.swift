//
//  BusinessSearch.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/12/21.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
