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
        AppManager.shared.resetDatas()
        AppManager2.shared.resetDatas()
        UserDictManager.shared.resetDatas()
        UserDataUDManager.shared.resetDatas()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDictUDUpdate() {
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

    func testDictUDBatchUpdate() {
        let build = 1
        let version = "0.0.2"
        
        var appManager = AppManager.shared
        
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
    
    func testCodableDefault() {
        let userManager = UserDictManager.shared
        
        XCTAssert(
            userManager[\.age] == nil &&
            userManager[\.name] == "default"
        )
    }
    
    func testCodableDictUpdate() {
        let age = 16
        let name = "HelloWorld"
        
        var userManager = UserDictManager.shared
        
        userManager[\.age] = age
        userManager[\.name] = name
        
        let udDict = userManager.ud.dictionary(forKey: UserDictManager.UDKey)
        XCTAssert(
            udDict?["age"] as? Int == age &&
            udDict?["name"] as? String == name
        )
    }
    
    func testCodableDictBatchUpdate() {
        let age = 16
        let name = "HelloWorld"
        
        var userManager = UserDictManager.shared
        
        userManager.batchUpdate { item in
            item.age = age
            item.name = name
        }
        
        let udDict = userManager.ud.dictionary(forKey: UserDictManager.UDKey)
        XCTAssert(
            udDict?["age"] as? Int == age &&
            udDict?["name"] as? String == name
        )
    }
    
    func testCodableDataUpdate() {
        let age = 16
        let name = "HelloWorld"
        
        var userManager = UserDataUDManager.shared
        
        userManager[\.age] = age
        userManager[\.name] = name
        
        let udDict = userManager.ud.dictionary(forKey: UserDataUDManager.UDKey)
        XCTAssert(
            udDict?["age"] as? Int == age &&
            udDict?["name"] as? String == name
        )
    }
    
    func testCodableDataBatchUpdate() {
        let age = 16
        let name = "HelloWorld"
        
        var userManager = UserDataUDManager.shared
        
        userManager.batchUpdate { item in
            item.age = age
            item.name = name
        }
        
        let udDict = userManager.ud.dictionary(forKey: UserDataUDManager.UDKey)
        XCTAssert(
            udDict?["age"] as? Int == age &&
            udDict?["name"] as? String == name
        )
    }
    
    func testStoreWrapper() {
        let build = 1
        let version = "0.0.2"
        
        let am = AppManager2.shared
        
        am.appStoreA.build = build
        am.appStoreA.version = version
        am.appStoreB.build = build
        am.appStoreB.version = version
        
        let udDictA = AppManager2.ud.dictionary(forKey: AppManager2.AppStoreAKey)
        let udDictB = AppManager2.ud.dictionary(forKey: AppManager2.AppStoreBKey)
        XCTAssert(
            udDictA?["build"] as? Int == build &&
            udDictA?["version"] as? String == version &&
            udDictB?["build"] as? Int == build &&
            udDictB?["version"] as? String == version
        )
    }
    
}
