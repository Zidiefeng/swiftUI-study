//
//  BusinessSection.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/12/21.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: "Restaurants")){
            // the items in ForEach need to conform to identifiable property
            // otherwise, we need to add id
            // we add identifiable in Business model in this case, so we do not need to add id parameter here
            ForEach(businesses){business in
                NavigationLink {
                    BusinessDetail(business: business)
                } label: {
                    BusinessRow(business: business)
                }

            }
        }
    }
}
//
//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection(title: , businesses: <#T##[Business]#>)
//    }
//}
