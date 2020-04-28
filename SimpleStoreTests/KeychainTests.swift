//
//  KeychainTests.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/28.
//  Copyright © 2020 skytoup. All rights reserved.
//

import XCTest
@testable import SimpleStore

class KeychainTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 好像是由于签名问题, 暂时没[想/找]到解决方案
//    func testKeychain() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let kc = Keychain(service: "test", account: "test", group: nil)
//        let data = "HelloWorld".data(using: .utf8) ?? Data()
//        kc.addOrUpdate(data)
//        XCTAssertEqual(kc.fetch(), data)
//    }

}
