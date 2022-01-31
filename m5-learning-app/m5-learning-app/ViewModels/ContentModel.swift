//
//  ContentModel.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 11/18/21.
//

import Foundation
import AVFoundation
import Firebase
import UIKit
class ContentModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    // List of modules
    @Published var modules: [Module] = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var CodeText = NSAttributedString()
    
    
    var styleData : Data?
    
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    init() {
        //Parse local style.html
        self.getLocalStyles()
        
        //get database modules
        self.getModules()
        
        //self.getRemoteData()
    }
    
    // MARK: data methods
    
    func getLessons(module: Module, completion: @escaping () -> Void){
        // specify path
        let collection = db.collection("modules").document(module.id).collection("lessons")
        
        // get documents
        collection.getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                // Array to track lessons
                var lessons = [Lesson]()
                
                // Loop through the documents and build array of lessons
                for doc in snapshot!.documents {
                    
                    // New lesson
                    var l = Lesson()
                    
                    l.id = doc["id"] as? String ?? UUID().uuidString
                    l.title = doc["title"] as? String ?? ""
                    l.video = doc["video"] as? String ?? ""
                    l.duration = doc["duration"] as? String ?? ""
                    l.explanation = doc["explanation"] as? String ?? ""
                    l.title = "asd"
                    
                    // Add the lesson to the array
                    lessons.append(l)
                }
                
                // loop through the published modules array and find the one that matches the id
                for (index, m) in self.modules.enumerated(){
                    //m is just an copy of the actual module
                    if m.id == module.id {
                        // set the lessons of the module
                        self.modules[index].content.lessons = lessons
                        
                        // call the completion closure
                        completion()
                    }
                }
            }
        }
        
    }
    
    func getQuestions(module: Module, completion: @escaping () -> Void) {
        
        // Specify path
        let collection = db.collection("modules").document(module.id).collection("questions")
        
        // Get documents
        collection.getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                // Array to track lessons
                var questions = [Question]()
                
                // Loop through the documents and build array of lessons
                for doc in snapshot!.documents {
                    
                    // New lesson
                    var q = Question()
                    
                    q.id = doc["id"] as? String ?? UUID().uuidString
                    q.content = doc["content"] as? String ?? ""
                    q.correctIndex = doc["correctIndex"] as? Int ?? 0
                    q.answers = doc["answers"] as? [String] ?? [String]()
                    
                    // Add the lesson to the array
                    questions.append(q)
                }
                
                // Setting the lessons to the module
                // Loop through published modules array and find the one that matches the id of the copy that got passed in
                for (index, m) in self.modules.enumerated() {
                    
                    // Find the module we want
                    if m.id == module.id {
                        
                        // Set the lessons
                        self.modules[index].test.questions = questions
                        
                        // Call the completion closure
                        completion()
                    }
                }
            }
        }
        
        
    }
    
    
    func getModules(){
        
        // specify path
        let collection = db.collection("modules")
        
        // get documents
        collection.getDocuments { snapshot, error in
            if error == nil && snapshot != nil{
                
                // create an array for the modules
                var modules = [Module]()
                
                //loop through the documents returned
                for doc in snapshot!.documents{
                    // create a new module instance
                    var m = Module()
                    
                    // parse out the values form the doc into the module instances
                    m.id = doc["id"] as? String ?? UUID().uuidString
                    m.category = doc["category"] as? String ?? ""
                    
                    // Parse the lesson content
                    let contentMap = doc["content"] as! [String:Any]
                    
                    m.content.id = contentMap["id"] as? String ?? ""
                    m.content.description = contentMap["description"] as? String ?? ""
                    m.content.image = contentMap["image"] as? String ?? ""
                    m.content.time = contentMap["time"] as? String ?? ""
                    
                    // Parse the test content
                    let testMap = doc["test"] as! [String:Any]
                    
                    m.test.id = testMap["id"] as? String ?? ""
                    m.test.description = testMap["description"] as? String ?? ""
                    m.test.image = testMap["image"] as? String ?? ""
                    m.test.time = testMap["time"] as? String ?? ""
                    
                    // add it to our array
                    modules.append(m)
                }
                
                // Assign our modules to the published property
                DispatchQueue.main.async {
                    self.modules = modules
                }
            }
        }
    }
    
    
    func getLocalStyles(){
        
//        // Get a url to the json file
//        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
//
//        do {
//            // Read the file into a data object
//            let jsonData = try Data(contentsOf: jsonUrl!)
//
//            // Try to decode the json into an array of modules
//            let jsonDecoder = JSONDecoder()
//            //use `.self` to pass the type
//            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
//
//            //assign modules to var
//            self.modules = modules
//        }
//        catch{
//            // log error
//            print("Could not parse local data")
//        }
//
        
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
    
    
    // MARK: get remote data
    func getRemoteData(){
        
        //String path
        let urlString = "https://codewithchris.github.io/learningapp-data/data2.json" //"https://zidiefeng.github.io/swiftUI-study/data.json"
        
        // create a url object
        let url = URL(string: urlString)
        
        // if no url, exit this data request
        guard url != nil else{
            return
        }
        
        // create a urlRequest object
        let request = URLRequest(url: url!)
        
        // get the session and kick of the task/request
        let session = URLSession.shared
        
        
        
        // returns data task object, so save as a container
        let dataTask = session.dataTask(with: request) { data, response, error in
            // data:returned data
            // response: additional info
            
            // check if there is an error
            guard error == nil else {
                // if there is an error, end this request
                return
            }
            
            do{
                //create json decoder
                let decoder = JSONDecoder()
                
                // decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                
                DispatchQueue.main.async {
                    self.modules += modules
                }
                
                
            }
            catch{
                print(error)
            }
        }
        
        // kick off the data task
        dataTask.resume()
        
    }
    
    
    
    // MARK: module navigation methods
    func beginModule(_ moduleId:String){
        
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
        CodeText = addStyling(currentLesson!.explanation)
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
        guard currentModule != nil else{
            return false
        }
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
            CodeText = addStyling(currentLesson!.explanation)
        }
        else{
            // reset lesson
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    
    
    func beginTest(_ moduleId: String){
        //set the current module
        beginModule(moduleId)
        
        //set the current question
        currentQuestionIndex = 0
        
        // if there are questions
        // if currentModule is nil, set to 0
        // if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            CodeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion(){
        // advance the question index
        currentQuestionIndex += 1
        
        //check that it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            CodeText = addStyling(currentQuestion!.content)
        }
        else{
            // if not, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
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

