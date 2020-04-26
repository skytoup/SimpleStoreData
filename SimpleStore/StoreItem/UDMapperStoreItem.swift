//
//  SimpleStoreUDItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`UserDefault`的`DictMapperStoreItem`
///
/// 警告提示: 放到`protocol`声明处, 改用`where`会更好(即上方的写法), 且效果一样
/// 但是在`swift 5.1`处有问题, 显示`DictMapValue`的`mapper`方法时, 会提示没有成员`Key`
///
/// ` where Key == String, Value == Any`实现协议`mapValue`编译提示`'Key' is not a member type of 'xxx'`
/// 暂时这样写, 旧 `public protocol UDMapperStoreItem: DictStoreItem, DictMapValue where Key == String, Value == Any `
///
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol UDMapperStoreItem: DictMapperStoreItem {
    typealias Key = String
    typealias Value = Any
}

extension UDMapperStoreItem {
    public init(datas: [Key : Value]) {
        self.init()
        var mapper = AssignUDMapper(dict: datas)
        mapValue(&mapper)
    }

    public mutating func archiveDict() -> [Key: Value] {
        var mapper = EvalUDMapper()
        mapValue(&mapper)
        return mapper.dict
    }
}
