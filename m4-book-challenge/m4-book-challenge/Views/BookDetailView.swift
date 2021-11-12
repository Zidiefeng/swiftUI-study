//
//  BookDetailView.swift
//  m4-book-challenge
//
//  Created by 孙恺檀 on 11/12/21.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    @State var selectedRating = 3
    @State var selectedFavorite = false
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .center){
                    
                    //MARK: header
                    Text(book.title)
                        .font(.headline)
                    Text("Read Now!")
                    
                    // MARK: book cover
                    
                        NavigationLink {
                            PageView(book: book)
                        } label: {
                            Image("cover"+String(book.id))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width*0.6)
                        }

                    
                    // MARK: mark for later
                    Text("Mark for later !")
                    Button {
                        selectedFavorite = !selectedFavorite
                    } label: {
                        selectedFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
                        
                    }


                    // MARK: rating
                    Text("Rate Amazing Words")
                    Picker("Rate Amazing Words", selection: $selectedRating) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                }
            }
        }

    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BookModel()
        BookDetailView(book: model.books[0])
    }
}
