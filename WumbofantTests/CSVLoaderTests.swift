//
//  CSVLoaderTests.swift
//  Wumbofant
//
//  Created by Simon Crequer on 13/07/15.
//  Copyright (c) 2015 Simon Crequer. All rights reserved.
//

import Cocoa
import XCTest

class CSVLoaderTests: XCTestCase {
    
    let expectedEntries: Int = 5272
    
    var url: NSURL?
    var loader: CSVLoader?
    
    override func setUp() {
        var bundle: NSBundle = NSBundle(forClass: self.dynamicType)
        url = bundle.URLForResource("sample-timesheet", withExtension: "csv")
        loader = CSVLoader(url: url!)
        
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
    Tests that the correct number of entries are loaded from the sample CSV file
    */
    func testLoadEntriesCount() {
        XCTAssert(loader != nil, "Loader is nil")
        
        if let entries = loader?.entries {
            let count: Int = entries.count
            XCTAssert(count == expectedEntries, "Entry count wrong: Got \(count), expected \(expectedEntries)")
        } else {
            XCTFail("No entries")
        }
        
    }
    
    /**
    Tests that the log entries loaded from the file match what is expected
    */
    func testLogEntriesMatchSampleData() {
        if let entries = loader?.entries {
            
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
            
        } else {
            XCTFail("Could not get entries from loader")
        }
    }
    
}