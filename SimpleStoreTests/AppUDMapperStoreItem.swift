//
//  AppUDItem.swift
//  SimpleStoreTests
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
@testable import SimpleStore

struct AppUDMapperStoreItem: UDMapperStoreItem {
    @UDMapperParam(key: "version", default: "") var version
    @UDMapperParam(key: "build", default: 0) var build
    
    mutating func mapValue<Mapper>(_ mapper: inout Mapper) where Mapper : DictMapper, Key == Mapper.Key, Value == Mapper.Value {
        mapper <- _version
        mapper <- _build
    }
}
