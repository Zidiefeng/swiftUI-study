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
    @State var isFavourite = false
    var body: some View {
        
//        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .center){
                    Spacer()
                    
                    //MARK: header
//                    Text(book.title)
//                        .font(.headline)
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

                    Spacer()
                    // MARK: mark for later
                    Text("Mark for later !")
                    Button {
                        isFavourite = !isFavourite
                    } label: {
                        isFavourite ? Image(systemName: "star.fill")
                            .foregroundColor(.yellow) : Image(systemName: "star")
                            .foregroundColor(.yellow)
                        
                    }
                    .onChange(of: isFavourite, perform: { newValue in
                        book.isFavourite = newValue
                        print(book.isFavourite)
                    })
                    .onAppear {
                        isFavourite = book.isFavourite
                    }
                    
                    Spacer()

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
                    .onAppear {
                        selectedRating = book.rating
                    }
                    .onChange(of: selectedRating) { newRating in
                        book.rating = newRating
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("\(book.title)")
        }

//    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BookModel()
        BookDetailView(book: model.books[0])
    }
}
