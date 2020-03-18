//
//  UDStoreTests.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import XCTest
@testable import SimpleStore

class UDStoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        AppManager.shared.cleanDatas()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdate() {
        let build = 1
        let version = "0.0.2"
        
        var appManager = AppManager.shared
        
        appManager[\.build] = build
        appManager[\.version] = version
        
        let udDict = appManager.ud.dictionary(forKey: AppManager.UDKey)
        XCTAssert(
            udDict?["build"] as? Int == build &&
            udDict?["version"] as? String == version
        )
    }

    func testBatchUpdate() {
        let build = 1
        let version = "0.0.2"
        
        let appManager = AppManager.shared
        
        appManager.batchUpdate { item in
            item.build = build
            item.version = version
        }
        
        let udDict = appManager.ud.dictionary(forKey: AppManager.UDKey)
        XCTAssert(
            udDict?["build"] as? Int == build &&
            udDict?["version"] as? String == version
        )
    }
}