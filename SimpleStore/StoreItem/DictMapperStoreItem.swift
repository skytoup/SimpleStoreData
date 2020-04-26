//
//  DictMapperStoreItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`dict`存储, `Mapper`映射的数据项
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol DictMapperStoreItem: DictStoreItem, DictMapValue {
}

extension DictMapperStoreItem {
    public init(datas: [Key: Value]) {
        self.init()
        var mapper = AssignDictMapper(dict: datas)
        mapValue(&mapper)
    }
    
    public mutating func archiveDict() -> [Key: Value] {
        var mapper = EvalDictMapper<Key, Value>()
        mapValue(&mapper)
        return mapper.dict
    }
}
