//
//  CSVLoader.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Cocoa
import CoreData

class CSVLoader {
    
    var url: NSURL
    
    init(url: NSURL) {
        self.url = url
        loadEntries()
    }
    
    lazy var entries: [LogEntry] = {
        let fetchRequest = NSFetchRequest(entityName: "LogEntry")
        let managedObjectContext = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [LogEntry]
        
        return fetchResults
    }()
    
    /**
    Loads the CSV file given by url and parses it into an array of LogEntry objects
    */
    func loadEntries() {
        var error: NSError?
        var contents: String? = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &error)
        
        if error != nil {
            println("Error fetching file contents: \(error)")
        } else if contents != nil {
            
            var lines: [String] = contents!.componentsSeparatedByString("\r\n")
            
            if lines[0] == "Product,Project,Iteration,Story,Task,Comment,User,Date,Spent effort (hours)" {
                lines.removeAtIndex(0)
                for line in lines {
                    let items = readLine(line)
                    
                    let dateFormatter: NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                    let date: NSDate = dateFormatter.dateFromString(items[7])!
                    
                    // Create a CoreData entity for the LogEntry that can be referenced from
                    // anywhere in the application
                    let entry = NSEntityDescription.insertNewObjectForEntityForName("LogEntry", inManagedObjectContext: (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!) as! LogEntry

                    entry.product = items[0]
                    entry.project = items[1]
                    entry.iteration = items[2]
                    entry.story = items[3]
                    entry.task = items[4]
                    entry.comment = items[5]
                    entry.user = items[6]
                    entry.date = date
                    entry.spentEffort = NSNumber(float: NSString(string: items[8]).floatValue)
                }
            }
        }
        
    }
    
    /**
    Parses a line from the CSV file into an array of Strings. Rather than treating
    every comma as a seperator, it first checks if a comma is inside "quotation
    marks" and only treats it as a seperator if it isn't.
    
    :param: line    The line of CSV data to be parsed
    
    :returns: An array of 9 Strings containing each part of the LogEntry
    */
    private func readLine(line: String) -> [String] {
        var values: [String] = ["","","","","","","","",""]
        var index: Int = 0
        var quoteReached: Bool = false
        
        for c in line {
            if c != "," && c != "\"" {
                values[index].append(c)
            } else if c == "\"" {
                if !quoteReached {
                    quoteReached = true
                } else {
                    quoteReached = false
                }
            } else if c == "," {
                if quoteReached {
                    values[index].append(c)
                } else {
                    index++
                }
            }
        }
        
        return values
    }
    
}