//
//  CSVLoaderTests.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Cocoa
import XCTest
import Wumbofant

class CSVLoaderTests: XCTestCase {
    
    let expectedEntries: Int = 5272
    
    var url: NSURL?
    var loader: CSVLoader?
    
    override func setUp() {
        var bundle: NSBundle = NSBundle(forClass: self.dynamicType)
        url = bundle.URLForResource("sample-timesheet", withExtension: "csv")
        // loader = CSVLoader(url: url!)
        
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
    Tests that the correct number of entries are loaded from the sample CSV file
    */
    func testLoadEntriesCount() {
        /*XCTAssert(loader != nil, "Loader is nil")
        
        if let entries = loader?.entries {
            let count: Int = entries.count
            XCTAssert(count == expectedEntries, "Entry count wrong: Got \(count), expected \(expectedEntries)")
        } else {
            XCTFail("No entries")
        }*/
        
    }
    
    /**
    Tests that the log entries loaded from the file match what is expected
    */
    func testLogEntriesMatchSampleData() {
        /*if let entries = loader?.entries {
            
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            var expectedDate: NSDate
            
            // First entry
            expectedDate = dateFormatter.dateFromString("17.03.2015 10:56")!
            XCTAssertEqual("1:SWS", entries[0].product)
            XCTAssertEqual("Murcs", entries[0].project)
            XCTAssertEqual("1: Walk before you can run", entries[0].iteration)
            XCTAssertEqual("Create a Basic App", entries[0].story)
            XCTAssertEqual("Create Cucumber Feature Files", entries[0].task)
            XCTAssertEqual("", entries[0].comment)
            XCTAssertEqual("Dion Woolley", entries[0].user)
            XCTAssertEqual(expectedDate, entries[0].date)
            XCTAssertEqual(1.0, entries[0].spentEffort)
            
            // 5271st (last) entry
            expectedDate = dateFormatter.dateFromString("07.07.2015 15:28")!
            XCTAssertEqual("6: soft.serve( )", entries[5271].product)
            XCTAssertEqual("Scrum Machine", entries[5271].project)
            XCTAssertEqual("3: Sprint Three - soft.serve(Scrum Machine)", entries[5271].iteration)
            XCTAssertEqual("Story Estimation", entries[5271].story)
            XCTAssertEqual("Update Story controller", entries[5271].task)
            XCTAssertEqual("#implement Connected comboboxes to scale and estimation attributes of story #commits[ebb7b87b] #detail Had some trouble with combobox actions being called when setting their initial state causing NullPointerExceptions. Fixed by adding preventCombo boolean #pair[jpn22]", entries[5271].comment)
            XCTAssertEqual("Simon Crequer", entries[5271].user)
            XCTAssertEqual(expectedDate, entries[5271].date)
            XCTAssertEqual(1.0, entries[5271].spentEffort)
            
            // 5219th entry (has comma in comment
            expectedDate = dateFormatter.dateFromString("22.05.2015 16:39")!
            XCTAssertEqual("6: soft.serve( )", entries[5219].product)
            XCTAssertEqual("Scrum Machine", entries[5219].project)
            XCTAssertEqual("3: Sprint Three - soft.serve(Scrum Machine)", entries[5219].iteration)
            XCTAssertEqual("Revert", entries[5219].story)
            XCTAssertEqual("BUGFIX: Add cancel button to cancel creation of items", entries[5219].task)
            XCTAssertEqual("#commits[a6a3a021c] Added cancel button on  creation of any person, team etc. so that creation can be cancelled. #pair[jpn22]]", entries[5219].comment)
            XCTAssertEqual("Joshua Norton", entries[5219].user)
            XCTAssertEqual(expectedDate, entries[5219].date)
            XCTAssertEqual(0.8, entries[5219].spentEffort)
            
        } else {
            XCTFail("Could not get entries from loader")
        }*/
    }
        
}