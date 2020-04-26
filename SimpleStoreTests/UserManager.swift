//
//  UserManager.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

class UserDictManager: SimpleStoreDictUD<UserStoreItem> {
    static let UDKey = "__user_dict__"
    static let shared = UserDictManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
}

class UserDataManager: SimpleStoreDataUD<UserStoreItem> {
    static let UDKey = "__user_data__"
    static let shared = UserDictManager(udKey: UDKey)
    
    func resetDatas() {
        item = Item()
    }
    
}
