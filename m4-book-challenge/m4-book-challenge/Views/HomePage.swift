//
//  HomePage.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject var model = BookModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // MARK: Home Page Title
                Text("My Library")
                    .font(.largeTitle)
                    .padding()
                
                // MARK: Scrollable Book Card
                ScrollView(.vertical) {
                    ForEach(model.books){b in
                        NavigationLink(destination: BookDetailView(book: b)) {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .foregroundColor(.white)
                                VStack(alignment: .leading, content: {
                                    Text(b.title)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text(b.author)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    Image("cover"+String(b.id))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        
                                        
                                })
                                    .padding()
                            }
                            .padding()
                            .cornerRadius(29)
                            .shadow(color: .gray, radius: 5, x: -5, y: 5)
                        }
                        
                    }
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
