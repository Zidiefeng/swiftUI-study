//
//  ContentView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                Text("What do you want to do today?")
                    .padding(.leading,20)
                
                
                ScrollView{
                    LazyVStack{
                        ForEach(model.modules){ module in
                            VStack(spacing: 20){
                                
                                
                                NavigationLink(tag: module.id.hash, selection: $model.currentContentSelected){
                                    ContentView()
//                                        .onDisappear(perform: {
//                                            model.currentModule = nil
//                                        })
                                        .onAppear {
                                            model.getLessons(module: module) {
                                                model.beginModule(module.id)
                                            }
                                        }
                                } label: {
                                    //Learning card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }

                                NavigationLink(tag: module.id.hash, selection: $model.currentTestSelected) {
                                    TestView()
                                        .onAppear {
                                            model.getQuestions(module: module, completion: {
                                                model.beginTest(module.id)
                                            })
                                        }
                                } label: {
                                    // Test card
                                    HomeViewRow(image: module.test.image, title: "Learn \(module.category)", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                }

//                                // To fix a prior bug:
//                                // when multiple navigation links in one view, typing one of them will automatically be jumped back to the parent view
//                                NavigationLink(destination: EmptyView()) {
//                                    EmptyView()
//                                }



                            }
                            .padding(.bottom, 12)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { newValue in
                if newValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { newValue in
                if newValue == nil {
                    model.currentModule = nil
                }
            }
            
            
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
