//
//  AppDictItem.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

struct AppDictItem: SimpleStoreDictItem {
    typealias Key = String
    typealias Value = String
    
    var version = ""
    var build = ""
    
    mutating func mapValue<Mapper>(_ mapper: inout Mapper) where Mapper : DictMapper, AppDictItem.Key == Mapper.Key, AppDictItem.Value == Mapper.Value {
        mapper.map(&version, key: "version", default: "0.0.1")
        mapper.map(&build, key: "build", default: "0")
    }

}
