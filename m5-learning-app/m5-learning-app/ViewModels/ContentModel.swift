//
//  ContentModel.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import Foundation
import AVFoundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules: [Module] = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    
    var styleData : Data?
    
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    init() {
        self.getLocalData()
    }
    
    // MARK: data methods
    func getLocalData(){
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            //use `.self` to pass the type
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //assign modules to var
            self.modules = modules
        }
        catch{
            // log error
            print("Could not parse local data")
        }
        
        
        // parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch{
            // log error
            print("Could not parse style data")
        }
        
        
        
    }
    
    // MARK: module navigation methods
    func beginModule(_ moduleId:Int){
        
        //Find the index for this module id
        for index in 0..<modules.count{
            if modules[index].id == moduleId{
                
                // find the matching module
                if modules[index].id == moduleId{
                    currentModuleIndex = index
                    break
                }
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    // MARK: lesson begin method
    func beginLesson(_ lessonIndex: Int){
        //check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count{
            currentLessonIndex = lessonIndex
        }
        else{
            currentLessonIndex = 0
        }
        
        // set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // set current lesson description
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    // MARK: check if there is next lesson
    func hasNextLesson() -> Bool {
//        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
//            return true
//        }
//        else {
//            return false
//        }
        
        // more direct way
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    // MARK: go to the next lesson
    func nextLesson(){
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            // update lesson descsription
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else{
            // reset lesson
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    
    
    func beginTest(_ moduleId: Int){
        //set the current module
        beginModule(moduleId)
        
        //set the current question
        currentQuestionIndex = 0
        
        // if there are questions
        // if currentModule is nil, set to 0
        // if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
        }
    }
    
    
    
    
    // this is private because this function is for internal use only
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // add the styling data
        if styleData != nil{
            data.append(contentsOf: self.styleData!)
        }
        
        // add the html data
        data.append(contentsOf: Data(htmlString.utf8))
        
        // convert to attributed string
        // ---------method 1: can respond to error
//        do {
//            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//            resultString = attributedString
//        }
//        catch
//        {
//            print("Could not turn html into attributed string")
//        }
  
        // ---------method 2: shorter but not be able to respond to errors
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            // if the condition after `try?` fails, this code will not be executed
            resultString = attributedString
        }
        
        
        return resultString
    }
}

