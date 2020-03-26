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


class MyAppManager {
    static let ud = UserDefaults.standard
    static let AppStoreAKey = "__my_app_a__"
    static let AppStoreBKey = "__my_app_b__"
    
    @SimpleStoreUDW<AppUDItem>(ud, udKey: AppStoreAKey) var appStoreA
    @SimpleStoreUDW<AppUDItem>(ud, udKey: AppStoreBKey) var appStoreB
    
    static let shared = MyAppManager()
    
    func cleanDatas() {
        UserDefaults.standard.set(nil, forKey: "__my_app_a__")
        UserDefaults.standard.set(nil, forKey: "__my_app_b__")
    }
}
