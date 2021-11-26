//
//  TestView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/22/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack{
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                //Question
                //17:00
                //Answers
                
                //Button to submit
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}