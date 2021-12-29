//
//  BusinessDetail.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/13/21.
//

import SwiftUI

struct BusinessDetail: View {
    var business: Business
    
    @State private var showDirections = false
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
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
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            

            
            // so many items, put in a group!
            Group{

                BusinessTitle(business: business)
                    .padding()
                Divider()
                
                // phone
                HStack{
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()

                Divider()
                
                // reviews
                HStack{
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
                
                // website
                HStack{
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
                
            }
            
            // get direction button
            Button {
                //Show directions
                showDirections = true
            } label: {
                ZStack{
                    
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding()
            .sheet(isPresented: $showDirections) {
                DirectionsView(business: business)
            }
            
            
        }
    }
}

//struct BusinessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetail()
//    }
//}
