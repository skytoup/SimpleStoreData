//
//  StoreItemTest.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import XCTest
@testable import SimpleStore

class StoreItemTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDictItemArchive() {
        let version = "0.0.2"
        let build = "1"
        
        var item = AppDictItem()
        
        item.version = version
        item.build = build
        
        XCTAssertEqual(item.archive(), ["version": version, "build": build])
    }

    func testUDItemArchive() {
        let version = "0.0.2"
        let build = 1
        
        var item = AppUDItem()
        
        item.version = version
        item.build = build
        
        let itemArchive = item.archive()
        XCTAssert(
            itemArchive["build"] as? Int == build &&
            itemArchive["version"] as? String == version
        )
    }
}
