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
                let a = MKPointAnnotation()
                
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
        uiView.removeAnnotations(uiView.annotations)
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
