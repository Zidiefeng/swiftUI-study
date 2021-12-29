//
//  DirectionsView.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/28/21.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading){
            // Business Title
            HStack{
                BusinessTitle(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name
                {
                    Link(destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!) {
                        Text("Open in Maps")
                    }
                }
                
            }
            .padding()
            
            //Directions view
            DirectionsMap(business: business)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
