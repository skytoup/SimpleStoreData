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

    func testDictMapperStoreItemArchive() {
        let version = "0.0.2"
        let build = "1"
        
        var item = AppDictMapperStoreItem()
        
        item.version = version
        item.build = build
        
        XCTAssertEqual(item.archiveDict(), ["version": version, "build": build])
    }

    func testUDMapperStoreItemArchive() {
        let version = "0.0.2"
        let build = 1
        
        var item = AppUDMapperStoreItem()
        
        item.version = version
        item.build = build
        
        let itemArchive = item.archiveDict()
        XCTAssert(
            itemArchive["build"] as? Int == build &&
            itemArchive["version"] as? String == version
        )
    }
    
    
    func testCodableDictStoreItemArchive() {
        let name = "HelloWorld"
        let age = 10
        
        var item = UserStoreItem()
        
        item.name = name
        item.age = age
        
        let itemArchive = item.archiveDict()
        XCTAssert(
            itemArchive["name"] as? String == name &&
            itemArchive["age"] as? Int == age
        )
    }
    
    func testCodableDataStoreItemArchive() {
        let name = "HelloWorld"
        let age = 10
        
        var item = UserStoreItem()
        
        item.name = name
        item.age = age
        
        let data = item.archiveData()
        let itemArchive = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
        XCTAssert(
            itemArchive?["name"] as? String == name &&
            itemArchive?["age"] as? Int == age
        )
    }
}
