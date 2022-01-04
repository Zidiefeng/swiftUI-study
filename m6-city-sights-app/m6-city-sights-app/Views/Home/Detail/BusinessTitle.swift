//
//  BusinessTitle.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/29/21.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading){
            // business name
            Text(business.name!)
                .font(.largeTitle)
            
            // address
            if business.location!.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            
            
            // rating
            Image("regular_\(business.rating ?? 0)")
        }
    }
}

//struct BusinessTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessTitle()
//    }
//}
