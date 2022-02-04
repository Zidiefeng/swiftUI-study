//
//  SwiftUIView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 11/9/21.
//

import SwiftUI

struct SwiftUIView: View {
    // keep track of the selected index of the picker
    // 2 way relationship
    // detect change of the user selection
    @State var selectedIndex = 1
    
    var body: some View {
        VStack{
            Picker("Tap Me", selection: $selectedIndex) {
                Text("Option 1")
                    .tag(1)
                Text("Option 2")
                    .tag(2)
                Text("Option 3")
                    .tag(3)
            }
            //.pickerStyle(MenuPickerStyle())
            .pickerStyle(SegmentedPickerStyle())
            
            Text("You've selected: \(selectedIndex)")
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
