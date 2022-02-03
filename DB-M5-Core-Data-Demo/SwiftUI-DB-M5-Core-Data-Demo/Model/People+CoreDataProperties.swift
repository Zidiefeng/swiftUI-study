//
//  People+CoreDataProperties.swift
//  SwiftUI-DB-M5-Core-Data-Demo
//
//  Created by 孙恺檀 on 2/2/22.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var age: String?
    @NSManaged public var array: [String]?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var family: Family?

}

extension People : Identifiable {

}
