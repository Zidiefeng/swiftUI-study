//
//  CodeTextView.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/21/21.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable {
    
    static var ho:String = "------0------"
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) ->  UITextView {
        let textView = UITextView()
        textView.isEditable = false // not let users to modify it

        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        
        // set the attributed text for the lesson
        // since `model.lessonDescription` is a published var in ObservableObject,
        // this can be updated accordingly
        textView.attributedText = model.CodeText
        
        // scroll back to the top
        // `scrollRectToVisible`: Scrolls a specific area of the content so that it is visible in the receiver.
        // `width: 1, height: 1` creates a space to go back while `width: 0, height: 0` does not work
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}


struct HomeView1: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        Text(CodeTextView.ho)
            .onAppear{
                print("jasdsadasd")
        }
    }
        
}
struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView1()
    }
}
