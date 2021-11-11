// CWC Module 4 Lesson 3 TabView example （single file）


//  TestView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/30/21.
//

import SwiftUI

struct TestTabView: View {
    
    // it will be notified when user select certain tag
    // tabIndex will be updated accordingly
    @State var tabIndex = 0
    
    var body: some View {
        
        // Tab View: define tabs and their associated views
        // using `$` for binding
        // two way binding:
            //when tabIndex is changed, the tab view will be switched accordingly
            //when user select certain tag, the tabIndex value will be updated as well
        TabView(selection: $tabIndex){
            // The first tab
            // this item is associated with the tab
            Text("This is Tab 1")
                .tabItem{
                    // how does the tab look like
                    VStack{
                        Image(systemName: "pencil")
                        Text("Tab 1")
                    }
                }
                // assign a tag index to this tag
                .tag(0)
            
            // The second tab
            VStack{
                Text("This is Tabe 2")
                Text("This is some more text")
            }
            .tabItem{
                VStack{
                    Image(systemName: "star")
                    Text("Tab 2")
                }
            }
            .tag(1)
        }
        

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestTabView()
    }
}
