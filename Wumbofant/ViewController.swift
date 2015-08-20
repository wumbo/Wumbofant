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
    
    let managedObjectContext: NSManagedObjectContext! = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var objects: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text.editable = false
        
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
            text.string = selectedItem
            println(selectedItem)
        }
    }
    
    func updateSideBar() {
        objects = NSMutableArray()
        
        // Create a fetch request
        let fetchRequest = NSFetchRequest(entityName: "LogEntry")
        
        fetchRequest.resultType = .DictionaryResultType
        fetchRequest.propertiesToFetch = Array(arrayLiteral: "product")
        
        // Fetch the results
        let items = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        // Get unique instances and sort
        let uniqueItems = NSSet(array: items!).sortedArrayUsingDescriptors([NSSortDescriptor(key: "product", ascending: true)])
        
        for item in uniqueItems {
            objects.addObject(item["product"] as! String)
        }
        
        self.sideBar.reloadData()
    }

}
