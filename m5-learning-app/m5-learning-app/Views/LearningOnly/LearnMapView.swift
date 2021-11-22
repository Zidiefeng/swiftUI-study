//
//  LearnMapView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/21/21.
//

import SwiftUI
import MapKit


struct LearnMapView: UIViewRepresentable {
    func makeUIView(context: Self.Context) -> MKMapView  {
        
        // Creates the view object and configures its initial state.
        let mapView = MKMapView()
        
        return mapView
    }
    
    // uiView: Your custom view object.
    // context: A context structure containing information about the current state of the system.
    func updateUIView(_ uiView: MKMapView, context: Self.Context){
        // Update the element if needed
        

    }


}

struct LearnMapView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMapView()
    }
}
