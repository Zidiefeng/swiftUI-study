//
//  ContentDetailView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/21/21.
//

import SwiftUI

// contains video player to show videos
import AVKit
struct ContentDetailView: View {
    
    @EnvironmentObject var model : ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack{
            if url != nil{
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            //Description
            CodeTextView()
            
            // Next lesson button
            if model.hasNextLesson(){

                    Button(action: {
                        model.nextLesson()
                    }) {
                        ZStack{
                            RectangleCardView(color: Color.green)
                                .frame(height: 48)
                            
                            Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                
            }
            else{
                // show the complete button instead
                Button(action: {
                    // take the user back to the home view
                    model.currentContentSelected = nil
                }) {
                    ZStack{
                        RectangleCardView(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
            }

        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
