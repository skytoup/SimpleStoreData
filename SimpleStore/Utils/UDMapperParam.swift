//
//  UDMapperParam.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

@propertyWrapper
/// 包装UDMapper数据的属性包装器
public struct UDMapperParam<T> {
    let key: String
    var value: T
    let defaultValue: T
    
    /// 初始化
    /// - Parameters:
    ///   - key: `字段`存储到`字典`的`Key`
    ///   - value: 处理无法取值时使用的的默认值
    public init(key: String, default value: T) {
        self.key = key
        self.value = value
        self.defaultValue = value
    }
    
    public var wrappedValue: T {
        get {
            value
        }
        set {
            value = newValue
        }
    }
}

infix operator <-
/// mapper操作简化
public func <- <T, Mapper: DictMapper>(left: inout Mapper, right: inout UDMapperParam<T>) where Mapper.Key == String {
    left.map(&right.value, key: right.key, default: right.defaultValue)
}
