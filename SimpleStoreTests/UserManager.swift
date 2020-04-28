//
//  UserManager.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

class UserDictManager: StoreDictUD<UserStoreItem> {
    static let UDKey = "__user_dict__"
    static let shared = UserDictManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
}

class UserDataUDManager: StoreDataUD<UserStoreItem> {
    static let UDKey = "__user_data__"
    static let shared = UserDictManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
}

class UserDataKcManager: StoreKeychain<UserStoreItem> {
    static let shared = UserDataKcManager(service: "test", account: "test")
    
    func resetDatas() {
        item = Item()
    }
}
