//
//  ContentModel.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/9/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    var locationManager = CLLocationManager()
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var placemark : CLPlacemark?
    
    override init(){
        // super represents NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
    }
    
    func requestGeolocationPermission(){
        // request permission from the user
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        
    }
    
    // MARK: location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
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
            
            // get the placemark
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!) { placemarks, error in
                if error == nil && placemarks != nil{
                    // take the first placemark
                    self.placemark = placemarks?.first
                }
            }
            
            
            // if we have the coordinates of the user, send into yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    // MARK: yelp API methods
    func getBusinesses(category: String, location: CLLocation){
        // Create URL
        
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
  
        var urlComponents = URLComponents(string: Constants.apiUrl)
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
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // get URLSession
            let session = URLSession.shared
            
            // create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                // check that there is not an error
                if error == nil {
                    // parse json
                    
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // sort businesses
                        
                        var businesses = result.businesses
                        businesses = businesses.sorted { b1 , b2 in
                            // for each two connected business, b1 and b2
                            // if true, b1 goes first, if false, b2 goes first
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // call the get image function of the businesses
                        for b in businesses{
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.sync {
                            // assign results to the appropriate property
//                            if category == Constants.sightsKey{
//                                self.sights = result.businesses
//                            }
//                            else if category == Constants.restaurantsKey{
//                                self.restaurants = result.businesses
//                            }
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = businesses
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            default:
                                break
                            }
                            
                        }

                    }
                    catch{
                        print(error)
                    }
                    
                }
            }
            
            // start the data task
            dataTask.resume()
        }

    }
}
