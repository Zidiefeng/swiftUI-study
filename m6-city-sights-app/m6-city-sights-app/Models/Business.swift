//
//  Business.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/11/21.
//

import Foundation
// class because: to do observable object, change image data
class Business: Decodable, Identifiable, ObservableObject{
    @Published var imageData: Data?
    
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        // look for the following cases for camel
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        // remaining used cases
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    func getImageData(){
        // check that image url is not nil
        guard imageUrl != nil else {
            return
        }
        // download the data for the image
        if let url = URL(string: imageUrl!){
            //get a session
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    DispatchQueue.main.async {
                        // set the image data
                        self.imageData = data!
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}

struct Location: Decodable{
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
}

struct Category: Decodable{
    var alis: String?
    var title: String?
    
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
