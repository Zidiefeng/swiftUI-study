//
//  BusinessMap.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/13/21.
//

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
