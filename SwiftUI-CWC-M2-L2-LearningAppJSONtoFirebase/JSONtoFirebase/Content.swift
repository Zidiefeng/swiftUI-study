//
//  Lesson.swift
//  LearningApp
//
//  Created by Micah Beech on 2020-10-06.
//

import Foundation

struct Module : Decodable, Identifiable {
    var id: Int
    var category: String
    var content: Content
    var test: Test
}

struct Content : Decodable, Identifiable {
    var id: Int
    var time: String
    var image: String
    var description: String
    var lessons: [Lesson]
}

struct Test : Decodable, Identifiable {
    var id: Int
    var time: String
    var image: String
    var description: String
    var questions: [Question]
}

struct Lesson : Decodable, Identifiable {
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
}

struct Question : Decodable, Identifiable {
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
