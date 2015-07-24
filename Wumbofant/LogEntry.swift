//
//  LogEntry.swift
//  
//
//  Created by Simon Crequer on 24/07/15.
//
//

import Foundation
import CoreData

class LogEntry: NSManagedObject {

    @NSManaged var product: String
    @NSManaged var project: String
    @NSManaged var iteration: String
    @NSManaged var story: String
    @NSManaged var task: String
    @NSManaged var comment: String
    @NSManaged var user: String
    @NSManaged var date: NSDate
    @NSManaged var spentEffort: NSNumber

}
