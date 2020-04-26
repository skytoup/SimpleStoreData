//
//  AppManager.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

class AppManager: SimpleStoreDictUD<AppUDMapperStoreItem> {
    static let UDKey = "__app__"
    static let shared = AppManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
    
}

class AppManager2 {
    static let ud = UserDefaults.standard
    static let AppStoreAKey = "__app_a__"
    static let AppStoreBKey = "__app_b__"
    
    @SimpleStoreDictUDW<AppUDMapperStoreItem>(ud, udKey: AppStoreAKey) var appStoreA
    @SimpleStoreDictUDW<AppUDMapperStoreItem>(ud, udKey: AppStoreBKey) var appStoreB
    
    static let shared = AppManager2()
    
    func resetDatas() {
        appStoreA = AppUDMapperStoreItem()
        appStoreB = AppUDMapperStoreItem()
    }
    
}
