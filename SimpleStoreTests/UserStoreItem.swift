//
//  UserUDItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

struct UserStoreItem: CodableDictStoreItem, CodableDataStoreItem {
    var name = "default"
    var age: Int?
}
