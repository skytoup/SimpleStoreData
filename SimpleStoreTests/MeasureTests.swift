//
//  MeasureTests.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import XCTest
@testable import SimpleStore

@available(OSX 10.15, *)
class MeasureTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        AppManager.shared.resetDatas()
        UserDictManager.shared.resetDatas()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceUDMapperSimpleWrite() throws {
        self.measure {
            AppManager.shared.item.version = "Simple Test"
        }
    }

    func testPerformanceUDCodableDictSimpleWrite() throws {
        self.measure {
            UserDictManager.shared.item.name = "Simple Test"
        }
    }
    
    func testPerformanceUDCodableDataSimpleWrite() throws {
        self.measure {
            UserDataUDManager.shared.item.name = "Simple Test"
        }
    }
}
