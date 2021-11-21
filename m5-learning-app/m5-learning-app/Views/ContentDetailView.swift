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
            // Next lesson button
            if model.hasNextLesson(){
                

                    Button(action: {
                        model.nextLesson()
                    }) {
                        ZStack{
                            Rectangle()
                                .frame( height: 48)
                                .foregroundColor(Color.green) // should not use background
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                    
                    
                
            }

        }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
