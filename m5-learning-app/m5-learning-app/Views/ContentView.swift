//
//  ContentView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/20/21.
//

import SwiftUI

struct ContentView: View {
    
    //var module: Module
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView{
            LazyVStack{
                
                // Confirm that currentModule is set
                if model.currentModule != nil{
                    ForEach(0..<model.currentModule!.content.lessons.count){index in
                        ContentViewRow(index: index)
                    }
                }

            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
