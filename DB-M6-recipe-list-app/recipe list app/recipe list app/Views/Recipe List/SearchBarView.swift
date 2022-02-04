//
//  SearchBarView.swift
//  recipe list app
//
//  Created by 孙恺檀 on 2/3/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Filter by...", text: $text)
                
                Button{
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
            }
            .padding()
        }
        .frame(height: 48)
        .foregroundColor(.gray)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: Binding.constant("hi"))
    }
}
