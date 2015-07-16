//
//  SpentEffort.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Foundation

struct LogEntry {
    
    var product: String = ""
    var project: String = ""
    var iteration: String = ""
    var story: String = ""
    var task: String = ""
    var comment: String = ""
    var user: String = ""
    var date: NSDate = NSDate()
    var spentEffort: Float = 0.0
    
}