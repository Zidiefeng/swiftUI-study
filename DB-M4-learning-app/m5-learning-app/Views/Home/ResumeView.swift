//
//  ResumeView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 2/1/22.
//

import SwiftUI

struct ResumeView: View {
    @EnvironmentObject var model: ContentModel
    
    @State var resumeSelected: Int?
    
    let user = UserService.shared.user
    
    var destination: some View {
        
        return Group {
            
            let module = model.modules[user.lastModule ?? 0]
            
            // determine if we need to go into a contentDetailView or a TestView
            if user.lastLesson! > 0 {
                // go to content detail view
                ContentDetailView()
                    .onAppear {
                        //fetch lessons
                        model.getLessons(module: module) {
                            model.beginModule(module.id)
                            model.beginLesson(user.lastLesson!)
                        }
                    }
            }
            else{
                // go to test view
                TestView()
                    .onAppear {
                        model.getQuestions(module: module) {
                            model.beginTest(module.id)
                            model.currentQuestionIndex = user.lastQuestion!
                        }
                    }
            }
        }
    }
    
    var resumeTitle: String {
        let module = model.modules[user.lastModule ?? 0]
        if user.lastLesson != 0 {
            // resume a lesson
            return "Learn \(module.category): Lesson \(user.lastLesson! + 1)"
        }
        else{
            // resume a test
            return "Learn \(module.category) Test: Question \(user.lastQuestion! + 1)"
        }
    }
    
    var body: some View {
        let module = model.modules[user.lastModule ?? 0]
        
        
        NavigationLink(destination: destination, tag: module.id.hash, selection: $resumeSelected) {
            ZStack{
                RectangleCardView(color: .white)
                    .frame(height: 66)
                HStack{
                    VStack(alignment: .leading){
                        Text("Continue where you left off:")
                        Text(resumeTitle)
                            .bold()
                    }
                    .foregroundColor(.black)
                    Spacer()
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(width:40,height:40)
                }
                .padding(.horizontal)
            }
        }
        
    }
}

struct ResumeView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeView()
    }
}
