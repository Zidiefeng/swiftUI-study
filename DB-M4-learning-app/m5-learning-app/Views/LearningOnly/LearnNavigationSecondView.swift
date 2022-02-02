//
//  LearnNavigationSecondView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/22/21.
//

import SwiftUI

struct LearnNavigationSecondView: View {
    
    @Binding var selectedIndex:Int?
    
    var body: some View {
        VStack{
            Text("Hello, World!")
            Button("Navigate Back"){
                selectedIndex = nil
            }
        }
        
    }
}
//
//struct LearnNavigationSecondView_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnNavigationSecondView()
//    }
//}
