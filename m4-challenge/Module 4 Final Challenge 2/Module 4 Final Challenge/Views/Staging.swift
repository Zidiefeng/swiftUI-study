//
//  Staging.swift
//  Module 4 Final Challenge
//
//  Created by Micah Beech on 2021-03-25.
//

import SwiftUI

struct Staging: View {
    
    @EnvironmentObject var model: ViewModel
    @State private var rating = 2
    
    var book: Book
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: BookContent(book: book)) {
                VStack {
                    Text("Read Now!")
                        .font(.title)
                        .accentColor(.black)
                    
                    Image("cover\(book.id)")
                        .resizable()
                        .scaledToFit()                }
            }
            .padding()
            
            Text("Mark for later!")
                .font(.headline)
            
            Button(action: { model.updateFavourite(forId: book.id) }) {
                Image(systemName: book.isFavourite ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .accentColor(.yellow)
            
            Spacer()
            
            Text("Rate \(book.title)")
                .font(.headline)
            
            Picker("Rate this book!", selection: $rating) {
                ForEach(1..<6) { index in
                    Text("\(index)")
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.leading, .trailing, .bottom], 60)
            .onChange(of: rating, perform: { value in
                model.updateRating(forId: book.id, rating: rating)
            })
            
        }
        .onAppear { rating = book.rating }
        .navigationBarTitle("\(book.title)")
    }
}

struct Staging_Previews: PreviewProvider {
    static var previews: some View {
        Staging(book: Book())
            .environmentObject(ViewModel())
    }
}
