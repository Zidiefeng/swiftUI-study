//
//  RectangleCardView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/22/21.
//

import SwiftUI

struct RectangleCardView: View {
    //default color
    var color = Color.white
    
    var body: some View {
        Rectangle()
//            .frame( height: 48)
            .foregroundColor(color) // should not use background
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCardView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCardView()
    }
}
