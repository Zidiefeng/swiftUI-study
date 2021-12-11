//
//  ContentModel.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/9/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init(){
        // super represents NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // request permission from the user
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        
        
        

    }
    
    // MARK: location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // current authorization status of the app
        if locationManager.authorizationStatus == CLAuthorizationStatus.authorizedAlways ||
        locationManager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse{
            // we have permission
            
            // start geolocating the user after getting the permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            // we do not have permission
        }
    }
    
    // MARK: get location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives us the location of the user
        let userLocation = locations.first
        if userLocation != nil {
            // stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // if we have the coordinates of the user, send into yelp API
            getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "restaurants", location: userLocation!)
        }
    }
    
    // MARK: yelp API methods
    func getBusinesses(category: String, location: CLLocation){
        // Create URL
        
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
  
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        var url = urlComponents?.url
        
        if let url = url {
            // Create URL request
            // cachePolicy: use cache or fresh data
            // timeout: how many seconds to wait before saying it's time out
            var request = URLRequest(url: url , cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "GET" // retreive data
            
            // from yelp website (https://www.yelp.com/developers/documentation/v3/authentication):
            // to authenticate API calls with the API Key, set the Authorization HTTP header value as Bearer API_KEY
            request.addValue("Bearer _ofQvQVrD31SJZh7Ghg4GZq4pwA1sFIZZ0cSas9fm0huFXCSFTCebfUH4TjeW63L4gPn02hHI3nkeXtsHzwR1McNf9ei-YFJWKBbt1FGN6g0aA9jR2qDmfEYyUa0YXYx", forHTTPHeaderField: "Authorization")
            
            // get URLSession
            let session = URLSession.shared
            
            // create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                // check that there is not an error
                if error == nil {
                    print(response)
                }
            }
            
            // start the data task
            dataTask.resume()
        }

    }
}
