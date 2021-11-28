//
//  TestView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/22/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex :Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack{
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                //Question
                CodeTextView()
                    .padding(.horizontal,20)
                
                //Answers
                ScrollView{
                    VStack{
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            ZStack{
                                if submitted == false {
                                    RectangleCardView(color: index == selectedAnswerIndex ? .gray : .white)
                                        .frame(height: 48)
                                }
                                else{
                                    
                                    //answer has been submitted
                                    if (index == model.currentQuestion?.correctIndex){
                                        // correct answer selected
                                        RectangleCardView(color: Color.green)
                                            .frame(height: 48)
                                    }
                                    else if (index == selectedAnswerIndex) &&
                                        (index != model.currentQuestion?.correctIndex){
                                        // wrong answer selected
                                        RectangleCardView(color: Color.red)
                                            .frame(height: 48)
                                    }
                                    else {
                                        RectangleCardView(color: Color.white)
                                            .frame(height: 48)
                                    }
                                    
                                    
                                    
                                }
                                
                                Button {
                                    // track this selected inde
                                    selectedAnswerIndex = index
                                    
                                    
                                } label: {
                                    Text(model.currentQuestion!.answers[index])
                                }
                                .disabled(submitted)

                            }
                           
                        }
                    }
                    .padding()
                    .accentColor(.black)
                    

                    
                }
                
                //Button to submit
                //submit button
                Button {
                    
                    // check if answer has been submitted
                    if submitted == true{
                        // answer has been submitted, move to the next question
                        model.nextQuestion()
                        
                        // reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    else{
                        // submit the answer
                        
                        // change submitted state to true
                        submitted = true
                        
                        if selectedAnswerIndex == model.currentQuestion?.correctIndex{
                            // check the answer and increment the counter
                            numCorrect += 1
                        }
                        
                    }
                    

                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.green)
                            .frame(height:40)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .disabled(
                    (selectedAnswerIndex == nil)
                )

            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            

        }
        else{
//            // test has not been loaded yet
//            ProgressView()
            
            // if current question is nil, show the result view
            TestResultView(numCorrect: numCorrect)
        }
    }
    
    
    var buttonText: String{
        // check if answer has been submitted
        if submitted {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                return "Finished"
            }
            else {
                // there is a next question
                return "Next"
            }
            
        }
        else{
            return "Submit"
        }
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
