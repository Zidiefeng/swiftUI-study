//
//  BusinessRow.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/12/21.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business: Business
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                //Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable() // neeed to go first
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                //Name and distance
                VStack(alignment: .leading){
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000))
                        .font(.caption)
                }
                
                Spacer()
                
                //Star rating and number of views
                VStack(alignment: .leading){
                    Image("regular_\(String(business.rating ?? 0))")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
                
            }
        }
    }
}

//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
