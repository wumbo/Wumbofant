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
    
    func windowDidBecomeMain(notification: NSNotification) {
        var fileChooser: NSOpenPanel = NSOpenPanel()
        fileChooser.canChooseFiles = true
        fileChooser.canChooseDirectories = false
        fileChooser.allowsMultipleSelection = false
        fileChooser.allowedFileTypes = ["csv"]
        fileChooser.beginSheetModalForWindow(self.window! , completionHandler: { (i) -> Void in
            if let url = fileChooser.URL {
                self.csvLoader = CSVLoader(url: url)
                (self.window!.contentViewController as! ViewController).text.string = "Hello"
            }
        })
    }
    
}