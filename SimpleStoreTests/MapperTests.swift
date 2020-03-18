//
//  MapperTests.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import XCTest
@testable import SimpleStore

class MapperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEvalDictMap() {
        let key0 = "0"
        let key1 = "1"
        
        var helloStr = "hello"
        var worldStr = "world"
        var mapper = EvalDictMapper<String, String>()
        
        mapper.map(&helloStr, key: key0, default: "")
        mapper.map(&worldStr, key: key1, default: "")
        
        XCTAssertEqual(mapper.dict, [key0: helloStr, key1: worldStr])
    }

    func testAssignDictMap() {
        let key0 = "0"
        let helloStr = "hello"
        
        var hello = ""
        let mapper = AssignDictMapper(dict: [key0: helloStr])
        
        mapper.map(&hello, key: key0, default: "")
        
        XCTAssertEqual(hello, mapper.dict[key0])
    }
    
    func testEvalUDMap() {
        let key0 = "0"
        let appleURL = URL(string: "https://apple.com")!
        let baiduURL = URL(string: "https://baidu.com")!
        
        var url = appleURL
        var mapper = EvalUDMapper()
        
        mapper.map(&url, key: key0, default: baiduURL)
        
        XCTAssertEqual(mapper.dict[key0] as? URL, url)
    }
    
    func testAssignUDMap() {
        let key0 = "0"
        let appleURL = URL(string: "https://apple.com")!
        let baiduURL = URL(string: "https://baidu.com")!
        let qqURL = URL(string: "https://qq.com")!
        
        var url = baiduURL
        let mapper = AssignUDMapper(dict: [key0: appleURL])
        
        mapper.map(&url, key: key0, default: qqURL)
        
        XCTAssertEqual(mapper.dict[key0] as? URL, url)
    }
}
