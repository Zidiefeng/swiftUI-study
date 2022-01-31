//
//  Person+CoreDataProperties.swift
//  SwiftUI-DB-M5-Core-Data-Demo
//
//  Created by 孙恺檀 on 1/14/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: String?
    @NSManaged public var array: [String]?

}

extension Person : Identifiable {

}
