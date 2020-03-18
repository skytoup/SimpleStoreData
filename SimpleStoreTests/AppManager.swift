//
//  AppManager.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

class AppManager: SimpleStoreUD<AppUDItem> {
    static let UDKey = "__app__"
    static let shared = AppManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
    
    func cleanDatas() {
        ud.set(nil, forKey: udKey)
    }
}
