//
//  SimpleStoreDictItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`字典`的存储数据项
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol SimpleStoreDictItem: SimpleStoreItem {
    /// `字典`的`key`类型
    associatedtype Key: Hashable
    /// `字典`的`value`类型
    associatedtype Value
    
    init()
    
    /// 使用一些数据初始化
    /// - Parameter datas: 初始化的数据
    init(datas: [Key: Value])
    
    /// 把`Item`的数据转为`字典`
    mutating func archive() -> [Key: Value]
    
    /// 映射数据, `字典` <-> `字段`
    /// - Parameter mapper: 映射器
    mutating func mapValue<Mapper: DictMapper>(_ mapper: inout Mapper) where Mapper.Key == Key, Mapper.Value == Value
}

extension SimpleStoreDictItem {
    public init(datas: [Key: Value]) {
        self.init()
        var mapper = AssignDictMapper(dict: datas)
        mapValue(&mapper)
    }
    
    public mutating func archive() -> [Key: Value] {
        var mapper = EvalDictMapper<Key, Value>()
        mapValue(&mapper)
        return mapper.dict
    }
}
