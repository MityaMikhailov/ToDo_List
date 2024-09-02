//
//  Task+CoreDataProperties.swift
//  ToDo_List
//
//  Created by Dmitriy Mikhailov on 02.09.2024.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

}

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskId: Int16
    @NSManaged public var dateCreate: Date
    @NSManaged public var executionStatus: Bool
    @NSManaged public var taskDescription: String
    @NSManaged public var taskName: String?

}

extension Task : Identifiable {

}
