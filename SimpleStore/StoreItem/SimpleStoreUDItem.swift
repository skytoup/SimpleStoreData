//
//  SimpleStoreUDItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

#if swift(>=5.2)
/// 使用`UserDefault`的`StoreItem`
public protocol SimpleStoreUDItem: SimpleStoreDictItem where Key == String, Value == Any { }
#else
/// 警告提示: 放到`protocol`声明处, 改用`where`会更好(即上方的写法), 且效果一样
/// 但是在`swift 5.1`处有问题, 显示`DictStoreItem`的`mapper`方法时, 会提示没有成员`Key`
public protocol SimpleStoreUDItem: SimpleStoreDictItem {
    typealias Key = String
    typealias Value = Any
}
#endif

extension SimpleStoreUDItem {
    public init(datas: [Key : Value]) {
        self.init()
        var mapper = AssignUDMapper(dict: datas)
        mapValue(&mapper)
    }
    
    public mutating func archive() -> [Key: Value] {
        var mapper = EvalUDMapper()
        mapValue(&mapper)
        return mapper.dict
    }
}
