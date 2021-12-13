//
//  BusinessSectionHeader.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/12/21.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
        
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "gu")
    }
}
