//
//  LearnNavigationLink.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/22/21.
//

import SwiftUI

struct LearnNavigationLink: View {
    
    @State var selectedIndex: Int?
    
    var body: some View {
        NavigationView{
            VStack(spacing:20){

                //link1 -> view2
                NavigationLink(tag: 1, selection: $selectedIndex) {
                    LearnNavigationSecondView(selectedIndex: $selectedIndex)
                } label: {
                    Text("Navigation Link 1")
                }
                
                
                //link2 -> view2
                NavigationLink(tag: 2, selection: $selectedIndex) {
                    LearnNavigationSecondView(selectedIndex: $selectedIndex)
                } label: {
                    Text("Navigation Link 2")
                }

            }

        }
    }
}

struct LearnNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        LearnNavigationLink()
    }
}
