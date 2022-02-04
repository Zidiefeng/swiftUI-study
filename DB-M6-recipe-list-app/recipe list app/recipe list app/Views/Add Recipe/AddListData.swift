//
//  AddListData.swift
//  recipe list app
//
//  Created by 孙恺檀 on 2/3/22.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    @State private var item: String = ""
    
    var title: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("\(title)")
                    .bold()
                TextField(placeholderText, text: $item )
                
                Button {
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        // clear the text box
                        item = ""
                    }
                } label: {
                    Text("Add")
                }

            }
            
            // list out the items added so far
            ForEach(list, id: \.self){ item in
                Text(item)
            }
        }
    }
}
