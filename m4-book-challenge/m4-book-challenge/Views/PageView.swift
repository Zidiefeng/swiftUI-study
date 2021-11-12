//
//  PageView.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import SwiftUI

struct PageView: View {
    var book: Book
    
    @State var selectedPage = 1
    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(0..<book.content.count) {i in
                VStack {
                    Text(book.content[i]).tag(i)
                        .padding()
                    Text(String(i))
                        .padding()
                }
            }
            
        }
        .tabViewStyle(.page)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BookModel()
        PageView(book: model.books[0])
    }
}
