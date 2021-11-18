//
//  ContentView.swift
//  Module 4 Final Challenge
//
//  Created by Micah Beech on 2021-03-25.
//

import SwiftUI

struct BookList: View {
    
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 30) {
                    ForEach(model.books) { book in
                        NavigationLink(destination: Staging(book: book)) {
                            BookPreview(book: book)
                                .padding([.leading, .trailing], 20)
                        }
                        // The NavigationLink is a known workaround for an issue identified in iOS 14.5 where the navigation link pops the view as per these forum threads:
                        // https://developer.apple.com/forums/thread/677333
                        // https://forums.swift.org/t/14-5-beta3-navigationlink-unexpected-pop/45279
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                    }
                    
                }
                .padding(.top)
            }
            .navigationTitle("My Library")
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
            .environmentObject(ViewModel())
    }
}
