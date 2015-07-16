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
    
    func testLoadEntries() {
        XCTAssert(loader != nil, "Loader is nil")
        
        if let entries = loader?.entries {
            let count: Int = entries.count
            XCTAssert(count == expectedEntries, "Entry count wrong: Got \(count), expected \(expectedEntries)")
        } else {
            XCTFail("No entries")
        }
        
        
    }
    
}