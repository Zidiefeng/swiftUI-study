# SwiftUI-CWC-M6

Created: December 9, 2021 10:37 PM
修改时间: January 4, 2022 1:13 PM
完成: No

### App Structure

- Structure
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled.png)
    
- View hierarchy and data flow
    - Launch view will determine if the app has the permission of geo-data from the user. If so, go to home view; if not, go to onboarding view
    - home view has 2 sub-views: map view and list view; and these 2 views can be directed to the business detail view
        
        ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%201.png)
        

### Set info like in `Info.plist`

[Info.plist Is Missing in Xcode 13 - Here's How To Get It Back](https://betterprogramming.pub/info-plist-is-missing-in-xcode-13-heres-how-to-get-it-back-1a7abf3e2514)

Edit the properties, just like you would’ve back in `Info.plist`

![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%202.png)

### Ask for location permission

- Configure the permission message
    - Click + on right of `Supported interface orientations (iPad)`
    - Enter `Privacy - Location When In Use Usage Description` as key, and enter message like `Grant permission to find restaurants and sights near you.` as value
        
        ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%203.png)
        
- code to ask permission
    - `locationManager.requestWhenInUseAuthorization()` is to ask permission to get location when user is using this app
    - `locationManager.requestAlwaysAuthorization()`  is to ask permission to always get location
    
    ```swift
    import Foundation
    import CoreLocation
    
    class ContentModel: ObservableObject {
        
        var locationManager = CLLocationManager()
        
        init(){
            // request permission from the user
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestAlwaysAuthorization()
        }
    }
    ```
    
- since we configured `Privacy - Location When In Use Usage Description` , the message shows as follows
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%204.png)
    
- make sure the following setting is not `none`
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%205.png)
    

### Delegate `locationManager` to `ContentModel`

- To be a delegator, the object needs to be `NSObject` and `CLLocationManagerDelegate`
- `NSObject` is an Objective C object and has a default `init()` , which need to be overwritten
- **How do you track if a user has granted location permissions?**
    - Check the authorization status of your CLLocationManager
    - Make sure to review the process of working with CLLocationManager, such as assigning the content monbv  del as the delegate of the location manager using NSObject
- ViewModels/ContentModel.swift
    
    ```swift
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
            print(locations.first ?? "no location")
            
            // if we have the coordinates of the user, send into yelp API
            
            // stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
        }
    }
    ```
    

### Yelp API

- go to yelp Fusion
    
    [Get Started - Yelp Fusion](https://www.yelp.com/developers/documentation/v3/get_started)
    
- Create a new app and get authentication
    - APIs will require you to sign up to get an API key/authorization code in order to make requests. The number of requests you make might be limited, since requests create load on the API provider's server.
    
    [https://www.yelp.com/developers/v3/manage_app](https://www.yelp.com/developers/v3/manage_app)
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%206.png)
    
    ```swift
    //**Client ID**
    S5VLWA78KMlpv6-mZG0OXQ
    
    //**API Key**
    _ofQvQVrD31SJZh7Ghg4GZq4pwA1sFIZZ0cSas9fm0huFXCSFTCebfUH4TjeW63L4gPn02hHI3nkeXtsHzwR1McNf9ei-YFJWKBbt1FGN6g0aA9jR2qDmfEYyUa0YXYx
    ```
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%207.png)
    
- Understand search API URL & parameters
    - `GET https://api.yelp.com/v3/businesses/search`
        
        [Business Search Endpoint - Yelp Fusion](https://www.yelp.com/developers/documentation/v3/business_search)
        
    - input parameter:
        - longitude, latitude
        - category
            
            [Category List](https://www.yelp.com/developers/documentation/v3/all_category_list)
            
- Set url
    - way 1 : URL string
        
        ```swift
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        let url = URL(string: urlString)
        ```
        
    - way 2: URLComponents
        - **What is the purpose of the URLComponents structure?**
            
            To construct a URL along with query items
            
            URLComponents is an alternative way to construct a URL, with the other method we covered being just using a string with passed in variables.
            
        
        ```swift
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
                    URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
                    URLQueryItem(name: "categories", value: category)
                    URLQueryItem(name: "limit", value: "6")
                ]
                var url = urlComponents?.url
        ```
        
- authentication
    
    > To authenticate API calls with the API Key, set the `Authorization` HTTP header value as `Bearer API_KEY`.
    > 
    
    [Authentication - Yelp Fusion](https://www.yelp.com/developers/documentation/v3/authentication)
    

### Proxyman

- Proxyman: A tool to track and debug network requests made by your device
- download app
    
    [Proxyman * Modern Web Debugging Proxy on macOS, iOS, Android devices and iOS Simulator.](https://proxyman.io/)
    
- proxy traffic on the computer
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%208.png)
    
- when running the Xcode app to access to yelp API, we can see the app in proxyman
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%209.png)
    
- to see the response of a request, we need authorize it
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2010.png)
    
- Now we can see the response of a request
    - we can see the request URL [`https://api.yelp.com/v3/businesses/search?latitude=37.785834&longitude=-122.406417&categories=restaurants&limit=6`](https://api.yelp.com/v3/businesses/search?latitude=37.785834&longitude=-122.406417&categories=restaurants&limit=6) and response code
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2011.png)
    

### API key security

- Way 1: Store API key in a private repo
- Way 2: Change the actual API key
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2012.png)
    

### Switch

```swift
// assign results to the appropriate property
if category == Constants.sightsKey{
    self.sights = result.businesses
}
else if category == Constants.restaurantsKey{
    self.restaurants = result.businesses
}

// switch
switch category {
case Constants.sightsKey:
    self.sights = result.businesses
case Constants.restaurantsKey:
    self.restaurants = result.businesses
default:
    break
}
```

### ProgressView

- **What is the use of ProgressView?**
    - Shows a spinner/another style to represent loading or a task being completed

### Section

- **What are the advantages of using a Section in SwiftUI?**
    - You can specify a header and footer for each section
    - You can pin section headers to the top when scrolling
- We can put things in a section and specify headers on the section level
    
    ```swift
    Section(header: Text("Restaurants").bold()){
        // the items in ForEach need to conform to identifiable property
        // otherwise, we need to add id
        // we add identifiable in Business model in this case, so we do not need to add id parameter here
        ForEach(model.restaurants){ business in
            Text(business.name ?? "")
            Divider()
        }
    }
    ```
    
- Using `pinnedViews` in `LazyVStack` with `Section` header, we can stick the header of the section to the top (always visible) when scrolling up
    
    ```swift
    ScrollView{
      LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
          
          Section(header: BusinessSectionHeader(title: "Restaurants")){
              // the items in ForEach need to conform to identifiable property
              // otherwise, we need to add id
              // we add identifiable in Business model in this case, so we do not need to add id parameter here
              ForEach(model.restaurants){ business in
                  Text(business.name ?? "")
                  Divider()
              }
          }
          
          Section(header: BusinessSectionHeader(title: "Sights")){
              ForEach(model.sights){ business in
                  Text(business.name ?? "")
                  Divider()
              }
          }
          
          
      }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2013.png)
    

### Make reusable view template

- template
    
    ```swift
    struct BusinessSection: View {
        var title: String
        var businesses: [Business]
        
        var body: some View {
            Section(header: BusinessSectionHeader(title: "Restaurants")){
                // the items in ForEach need to conform to identifiable property
                // otherwise, we need to add id
                // we add identifiable in Business model in this case, so we do not need to add id parameter here
                ForEach(businesses){business in
                    Text(business.name ?? "")
                    Divider()
                }
            }
        }
    }
    ```
    
- use
    
    ```swift
    struct BusinessList: View {
        
        @EnvironmentObject var model: ContentModel
        
        var body: some View {
            ScrollView{
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
                    
                    BusinessSection(title: "Restaurants", businesses: model.restaurants)
                    BusinessSection(title: "Sights", businesses: model.sights)
                }
            }
        }
    }
    ```
    

### Use `CodingKeys` to map camel case var name with json style name in DB

- **How can you customize model property names when retrieving JSON data?**
    - Using CodingKeys to map property names
    - Even though the JSON data will have specific property/key names, you can use CodingKeys to map those names to any custom property names. Simply renaming the properties in your model will not work since the JSON can no longer be parsed.
- Specify the mapping rules in model struct Business.swift
    - Specify where the names are different
    - List other var names
    
    ```swift
    struct Business: Decodable, Identifiable{
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
    }
    ```
    
- There would be a `Decoable` error if the mapping name specified in `CodingKeys` does not match any var name defined in the struct/class
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2014.png)
    
    [](https://codecrew.codewithchris.com/t/module-6-lesson-7-capturing-image-data/15056/10)
    

### format string to rounded number

- round to 1 decimal place
    
    ```swift
    Text(String(format: "%.1f", business.distance ?? 0)/1000))
    ```
    
- with extra text
    
    ```swift
    Text(String(format: "%.1f km away", business.distance ?? 0/1000))
    ```
    

### Fetch image data from URL

- **How do you display an Image from an image URL?**
    - Get the image data from a URL request and use UIImage, ex: UIImage(imageData)
    - First, you need to get the image data using a URL request. After that, you can create a UIImage with the data and then pass that UIImage into the Image() view.
- Models/Business.swift
    - Add `@Published var imageData: Data?` on the business model
    - Add `getImageData()` to load UIImage data from remote url
    
    ```swift
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
    ```
    
- ViewModels/ContentModel.swift
    - load images for each business right after parsing json by decoder)
    
    ```swift
    for b in result.businesses{
        b.getImageData()
    }
    ```
    
    ```swift
    func getBusinesses(category: String, location: CLLocation){
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        var url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url , cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "GET" // retreive data
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
    
                        // call the get image function of the businesses
                        for b in result.businesses{
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.sync {
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
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
    ```
    

### Hide scroll Indicator on the right

- set parameter `showsIndicators: false`
    
    ```swift
    struct BusinessList: View {
        
        @EnvironmentObject var model: ContentModel
        
        var body: some View {
            ScrollView(showsIndicators: false){
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
                    
                    BusinessSection(title: "Restaurants", businesses: model.restaurants)
                    BusinessSection(title: "Sights", businesses: model.sights)
                }
            }
        }
    }
    ```
    

### To get a default business

```swift
// static function, nothing to do with particular instance
static func getTestData() -> Business {
    let b = Business()
    return b
}
```

### Navigation View Hierarchy

- Consider where to put `NavigationView`
    - `NavigationView` zone will be updated after triggering a navigation link
    - If putting `NavigationView` on just a small portion of the view, that part ONLY will be navigated to the next view
- `NavigationView` can be put on different view from `NavigationLink`

### Link to other apps in the phone

- specify URL to call other apps
- **How can you implement a link to a URL or app?**
    - Using the SwiftUI provided Link view
    - The Link view allows for opening of URLs and other apps. NavigationLink, on the other hand, is for navigating between screens.
- Using `Link` to direct to phone call
    
    ```swift
    // phone
    HStack{
        Text("Phone:")
            .bold()
        Text(business.displayPhone ?? "")
        Spacer()
        Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
    }
    ```
    
- Using `Link` to direct to website
    
    ```swift
    HStack{
        Text("Reviews:")
            .bold()
        Text(String(business.reviewCount ?? 0))
        Spacer()
        Link("Read", destination: URL(string: "\(business.url ?? "")")!)
    }
    ```
    
- reference
    
    [About Apple URL Schemes](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html)
    

### Use GeometryReader to wrap a section in the view

- Use GeometryReader to constrain the image section
    
    ```swift
    struct BusinessDetail: View {
        var business: Business
        
        var body: some View {
            VStack(alignment: .leading){
    	          GeometryReader { geo in
    	                // business image
    	                let uiImage = UIImage(data: business.imageData ?? Data())
    	                Image(uiImage: uiImage ?? UIImage())
    	                    .resizable()
    	                    .scaledToFit()
    	                    .frame(width: geo.size.width, height: geo.size.height)
    	                    .clipped()
    	            }
    	            .ignoresSafeArea(.all, edges: .top)
                
                
                // open / closed indicator
                ZStack(alignment:.leading){
                    ...
                }
                
                // so many items, put in a group!
                Group{
                    ...
                }
            }
        }
    }
    ```
    

### Limit number of lines in Text()

- code
    
    ```swift
    Text(business.url ?? "")
      .lineLimit(1)
    ```
    

### UIKit - MapView

- set up the structure (Views/Home/Map/BusinessMap.swift)
    
    ```swift
    import Foundation
    import SwiftUI
    import MapKit
    
    struct BusinessMap: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
    				// create the initial view
            <#code#>
    		}
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            // update view, can call methods of the UIKit view, change properties
            <#code#>
        }
        
        static func dismantleUIView(_ uiView: UIViewType, coordinator: ()) {
            // When this is not needed, we can clean up the UIKit view
            <#code#>
        }
    }
    ```
    
- **What does the dismantleUIView method do?**
    - Cleans up the UIView when it is no longer needed
- The view can take environment object like a normal view
- **How do you add annotations to a MKMapView?**
    - Use MKPointAnnotation()
    - Annotations can be directly added using MKPointAnnotation and specifying coordinates
- Fill in the structure
    
    ```swift
    import Foundation
    import SwiftUI
    import MapKit
    
    struct BusinessMap: UIViewRepresentable {
        
        @EnvironmentObject var model: ContentModel
        
        var locations: [MKPointAnnotation] {
            
            var annotations = [MKPointAnnotation]()
            
            // create a set of annotations from our list of businesses
            for business in model.restaurants + model.sights {
                
                // if the business has a lat/long, create an MKPointAnnotation for it
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                    
                    // create a new annotation
                    var a = MKPointAnnotation()
                    
                    a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    a.title = business.name ?? ""
                    
                    annotations.append(a)
                }
            }
            return annotations
        }
        
        func makeUIView(context: Context) -> MKMapView {
            // create UIKit view
            let mapView = MKMapView()
            
            // properties
            //make the user show up on the map
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .followWithHeading
            
            // Todo: set the region
            return mapView
        }
        
        func updateUIView(_ uiView: MKMapView, context: Context) {
            // update view, can call methods of the UIKit view, change properties
            
            // remove all annotations
            uiView.removeAnnotations(uiView.annotations)
    
            // add the ones based on the business
            //uiView.addAnnotations(self.locations)
            // add annotations and zoom as well
            uiView.showAnnotations(self.locations, animated: true)
            
        }
        
        static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
            // When this is not needed, we can clean up the UIKit view
            uiView.removeAnnotations(uiView.annotations     )
        }
    }
    ```
    

### UIKit delegate object

- The UIKit view communicates with the delegate object through method calls
    - for example, the map view call specific methods on the delegate objects to execute functions
    - the UIKit view know that the delegate object will have a certain set of methods to call (default methods) since the delegate object will conform to the relevant protocol (like `MKMapViewDelegate` below)
        
        ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2015.png)
        
    - For example, we can create an instance of `MKMapViewDelegate` and assign it to the delegate of the map view
- Explanation
    - As shown below, Partner conforms to `MKMapViewDelegate`, and needs to define functions a, b, and c
    - We create an instance from Partner and assign it to the delegate of `mapView`
    - `mapView` already knows that the delegate must have defined functions a, b, and c; therefore, it can calls the methods of the delegate object
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2016.png)
    
- Relationship between UIKit views and its delegate objects
    - the map view will ask the delegate object like what annotation views to show
    - when the user taps the annotation, the map view will notify the delegate object to see what to do next
- **How does the protocol delegate pattern help handle events for a MapView?**
    - The MapView will have a partner that has a defined set of methods that it knows it can call for information or give information to
    - The protocol delegate pattern is a commonly used pattern when working with UIKit, although less often in SwiftUI. We can call methods in the delegate to run when an event is detected, and the delegate can also be notified when an event occurs.
- Create a delegate object
    
    ![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2017.png)
    
- code
    
    ```swift
    import Foundation
    import SwiftUI
    import MapKit
    
    struct BusinessMap: UIViewRepresentable {
        
        @EnvironmentObject var model: ContentModel
        
        var locations: [MKPointAnnotation] {
    			...
        }
        
        func makeUIView(context: Context) -> MKMapView {
            // create UIKit view
            let mapView = MKMapView()
            
            // create a delegate
            // the map view will ask the delegate object like what annotation views to show
            // when the user tap the annotation, the map view will notify the delegate object to see what to do next
            // if there is an existing coordinator, use that coordinator
            // if there is not an coordinator, create a new one
            mapView.delegate = context.coordinator
            
            
            // properties
            //make the user show up on the map
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .followWithHeading
            
            // Todo: set the region
            return mapView
        }
        
        func updateUIView(_ uiView: MKMapView, context: Context) {
            ...
        }
        
        static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
    				...
        }
        
        // MARK: coordinator
        
        // get automatically called when we need an instance of coordinator class
        func makeCoordinator() ->  Coordinator {
            return Coordinator()
        }
        
        // declare this inside the view
        // NSObject: to conform to MKMapViewDelegate, this need conform to NSObject (this is objective C stuff)
        class Coordinator: NSObject, MKMapViewDelegate {
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                // Create an annotation view
                
                // if the annotation is the user blue dot, return nil
                if annotation is MKUserLocation {
                    // check the type
                    return nil
                }
                
                // check if there is a reusablw annotation view first
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
                
                if annotationView == nil {
                    // create a new one
                    // assign a identifier to re-use annotation view even if it is out of the zoom
                    annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                    
                    // return it
                    annotationView!.canShowCallout = true
                    annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                    
                }
                else {
                    // we have a reusable one
                    annotationView!.annotation = annotation
                }
                
                return annotationView
            }
        }
        
        
    }
    ```
    

### Check type

```swift
if annotation is MKUserLocation {
    // check the type
    return nil
}
```

### **What does the Binding property do when passed as a variable to a view?**

- It acts as a two way binding to the State variable in the parent view, so that the child view can modify the variable
- Bindings are good to use when a child view needs to track/modify a variable from a parent view
- example
    
    ```swift
    if let lat = business.coordinates?.latitude,
       let long = business.coordinates?.longitude,
       let name = business.name
    {
        Link(destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!) {
            Text("Open in Maps")
        }
    }
    ```
    

### **What should you do when you want to use special characters (apostrophes, spaces, etc.) in a URL link?**

- Encode the string of characters using methods like addingPercentEncoding
- Methods like addingPercentEncoding encode characters such as spaces and apostrophes, which cannot be directly used in URLs.

### Directions view

- update view
    - if we need to wait for some data on the map view and don’t want it to be empty, we can remove the annotations and overlays on the map view through updateView; however, if we already have the data we can skip it
- code
    
    ```swift
    //
    //  DIrectionsMap.swift
    //  m6-city-sights-app
    //
    //  Created by 孙恺檀 on 12/29/21.
    //
    
    import SwiftUI
    import MapKit
    
    struct DirectionsMap: UIViewRepresentable {
        
        @EnvironmentObject var model: ContentModel
        var business: Business
        var start: CLLocationCoordinate2D{
            return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        }
        
        var end: CLLocationCoordinate2D{
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                return CLLocationCoordinate2D(latitude: lat, longitude: long)
            }
            else{
                return CLLocationCoordinate2D()
            }
        }
        
        func makeUIView(context: Context) -> MKMapView {
            // create map
            let map = MKMapView()
            map.delegate = context.coordinator
            
            // show the user location
            map.showsUserLocation = true
            map.userTrackingMode = .followWithHeading
            
            // create directions request
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
            // create directions object
            let directions = MKDirections(request: request)
            
            // calculate route
            directions.calculate { response, error in
                if error == nil && response != nil {
                    
                    //plot the routes on the map
                    for route in response!.routes{
                        map.addOverlay(route.polyline)
                        
                        //zoom into the region
    //                    map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                        map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                    }
                }
            }
            
            // place annotation for the end point
            let annotation = MKPointAnnotation()
            annotation.coordinate = end
            annotation.title = business.name ?? ""
            map.addAnnotation(annotation)
            return map
        }
        func updateUIView(_ uiView: MKMapView, context: Context) {
            
        }
        static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
            uiView.removeAnnotations(uiView.annotations)
            uiView.removeOverlays(uiView.overlays)
        }
        
        // MARK - Coordinator
        func makeCoordinator() -> Coordinator {
            return Coordinator()
        }
        
        class Coordinator: NSObject, MKMapViewDelegate{
            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
                renderer.lineWidth = 5
                renderer.strokeColor = .blue
                return renderer
            }
        }
        
    }
    ```
    

![Untitled](SwiftUI-CWC-M6%20bb63385fa8d24bb09fdec49e67ae7525/Untitled%2018.png)

### Open settings for an app

- get the URL `UIApplication.openSettingsURLString`
- test if the URL can be opened and then open it
    
    ```swift
    Button {
        // open settings
        if let url = URL(string: UIApplication.openSettingsURLString){
            
            // if we can open the settings url
            if UIApplication.shared.canOpenURL(url){
                // pass empty dictionary and no handler
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    } label: {
        ZStack{
            Rectangle()
                .frame(height: 48)
                .cornerRadius(10)
                .foregroundColor(.white)
            Text("Go to Settings")
                .bold()
                .foregroundColor(backgroundColor)
        }
    }
    ```
    

### Onboarding process

```swift
struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        // detect the authorization status of geolocation
        if model.authorizationState == .notDetermined {
            // if undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // if approved, show home view
            HomeView()
        }
        else{
            // if denied, show denied view
            LocationDeniedView()
        }
    }
}
```

### Link & icon

- create a template icon to link to certain url
    
    ```swift
    import SwiftUI
    
    struct YelpAttribution: View {
        
        var link: String
        
        var body: some View {
            Link(destination: URL(string: link)!) {
                Image("yelp")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
            }
        }
    }
    
    struct YelpAttribution_Previews: PreviewProvider {
        static var previews: some View {
            YelpAttribution(link: "https://yelp.ca")
        }
    }
    ```
    

### Divider View

- **What is the Path type in SwiftUI?**
    - A type to create custom 2D shapes
- Use geometry reader to occupy the space and return relevant size
    
    ```swift
    import SwiftUI
    
    struct DashedDivider: View {
        var body: some View {
            GeometryReader{geo in
                Path{ path in
                    path.move(to: CGPoint.zero)
                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                }
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(.gray)
            }
    
        }
    }
    ```
    

### Use placemark to get located city

```swift
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
```