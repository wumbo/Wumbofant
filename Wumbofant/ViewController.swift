//
//  ViewController.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet var text: NSTextView!
    @IBOutlet weak var sideBar: NSTableView!
    
    var objects: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text.editable = false
        
        objects.addObject("Team 1")
        objects.addObject("Team 2")
        objects.addObject("Team 3")
        objects.addObject("Team 4")
        objects.addObject("Team 5")
        objects.addObject("Team 6")
        
        self.sideBar.reloadData()
    }
    
    // MARK: - Sidebar
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return objects.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellView = sideBar.makeViewWithIdentifier("cell", owner: self) as! NSTableCellView
        cellView.textField?.stringValue = self.objects.objectAtIndex(row) as! String
        
        return cellView
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        if sideBar.selectedRow != -1 {
            let selectedItem = self.objects.objectAtIndex(self.sideBar.selectedRow) as! String
        }
    }

}
