//
//  WindowController.swift
//  Wumbofant
//
//  Created by Simon Crequer on 22/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
    
    var csvLoader: CSVLoader?
    var fileLoaded: Bool = false
    
    func windowDidBecomeMain(notification: NSNotification) {
        let managedObjectContext = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "LogEntry")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [LogEntry]
        
        // Only show the dialog if there are no entries
        if !fileLoaded && fetchResults.count == 0 {
            openFile()
            fileLoaded = true
        }
        
        showHours()
    }
    
    func openFile() {
        var fileChooser: NSOpenPanel = NSOpenPanel()
        fileChooser.canChooseFiles = true
        fileChooser.canChooseDirectories = false
        fileChooser.allowsMultipleSelection = false
        fileChooser.allowedFileTypes = ["csv"]
        fileChooser.beginSheetModalForWindow(self.window! , completionHandler: { (i) -> Void in
            if let url = fileChooser.URL {
                self.csvLoader = CSVLoader(url: url)

                self.showHours()
            }
        })
    }
    
    func showHours() {
        let managedObjectContext = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "LogEntry")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [LogEntry]
        
        // <Product, <Sprint, <User, Hours>>>
        var sprintHours: Dictionary<String, Dictionary<String, Dictionary<String, Float>>> = Dictionary()
        for entry: LogEntry in fetchResults {
            
            // If product is in dictionary
            if contains(sprintHours.keys.array, entry.product) {
                // If sprint is in dictionary
                if contains(sprintHours[entry.product]!.keys.array, entry.iteration) {
                    // If user is in dictionary
                    if contains(sprintHours[entry.product]![entry.iteration]!.keys.array, entry.user) {
                        sprintHours[entry.product]![entry.iteration]![entry.user]! += entry.spentEffort as Float
                    } else {
                        sprintHours[entry.product]![entry.iteration]![entry.user] = entry.spentEffort as Float
                    }
                } else {
                    sprintHours[entry.product]![entry.iteration] = Dictionary()
                    sprintHours[entry.product]![entry.iteration]![entry.user] = entry.spentEffort as Float
                }
            } else {
                sprintHours[entry.product] = Dictionary()
                sprintHours[entry.product]![entry.iteration] = Dictionary()
                sprintHours[entry.product]![entry.iteration]![entry.user] = entry.spentEffort as Float
            }
        }
        
        var output = ""
        
        for product in sprintHours {
            output += product.0 + "\n"
            for sprint in product.1 {
                output += "\t" + sprint.0 + "\n"
                for user in sprint.1 {
                    output += "\t\t" + user.0 + ": "
                    output += toString(user.1) + " hours\n"
                }
            }
        }
        
        (self.window!.contentViewController as! ViewController).text.string = output
    }
    
}