//
//  CSVLoader.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Foundation

class CSVLoader {
    
    var url: NSURL
    var entries: [LogEntry]
    
    init(url: NSURL) {
        self.url = url
        entries = []
        loadEntries()
    }
    
    func loadEntries() {
        var error: NSError?
        var contents: String? = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &error)
        
        if error != nil {
            println("Error fetching file contents: \(error)")
        } else if contents != nil {
            var lines: [String] = readLines(contents!)
            if lines[1] == "Product,Project,Iteration,Story,Task,Comment,User,Date,Spent effort (hours)" {
                lines.removeAtIndex(0)
                lines.removeAtIndex(0)
                for line in lines {
                    let items = readLine(line)
                    
                    let dateFormatter: NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                    let date: NSDate = dateFormatter.dateFromString(items[7])!
                
                    var entry: LogEntry = LogEntry()
                    entry.product = items[0]
                    entries.append(entry)
                }
            }
        }
    }
    
    private func readLines(fileContents: String) -> [String] {
        var lines: [String] = fileContents.componentsSeparatedByString("\r\n")
        
        return lines
    }
    
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