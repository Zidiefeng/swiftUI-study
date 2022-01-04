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
    
    @State var selectedBusiness: Business?
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                // determine if we should show list of map
                if !isMapShowing {
                    // show list
                    VStack{
                        // header
                        HStack{
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button {
                                self.isMapShowing = true
                            } label: {
                                Text("Switch to map view")
                            }

                        }
                        Divider()
                        ZStack(alignment: .top){
                            BusinessList()
                            HStack{
                                Spacer()
                                YelpAttribution(link: "https://yelp.ca")
                            }
                            .padding(.trailing, -20)
                        }
                        
                    }
                    .padding([.horizontal, .top])
                    // this attached to the child of navigation view instead itself
                    .navigationBarHidden(true)
                }
                else{
                // Show map
                    ZStack(alignment: .top){
                        BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) {
                            
                        } content: { business in
                            // create a business detail view instance
                            // pass in the selected business
                            BusinessDetail(business: business)
                        }
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack{
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "")
                                Spacer()
                                Button("Switch to list view"){
                                    self.isMapShowing = false
                                }
                            }
                        }
                        .padding()
                    }
                    
                    // navigation title is specified by the child view instead of the navigation view
                    .navigationBarHidden(true)

                }
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
