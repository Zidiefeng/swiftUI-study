//
//  HomeView.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/12/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            // determine if we should show list of map
            if !isMapShowing {
                // show list
                VStack{
                    // header
                    HStack{
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("Switch to map view")
                    }
                    Divider()
                    
                    BusinessList()
                }.padding([.horizontal, .top])
            }
            else{
                //
            }
        }
        else{
            // show loading view
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
