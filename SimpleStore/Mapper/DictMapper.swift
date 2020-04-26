//
//  DictMapper.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 字典映射
/// 把一些`字段`的数据取出到`dict`, 或者把`dict`的数据赋值到`字段`
public protocol DictMapper {
    associatedtype Key: Hashable
    associatedtype Value

    var dict: [Key: Value] { get }
    
    /// `字段`的数据取值到`dict` 或 `dict`的数据赋值`字段`
    /// - Parameters:
    ///   - field: 操作的字段
    ///   - key: 字典对应的`key`
    ///   - defaultValue: 默认值, 取到的数据为nil, 或者转换失败时的默认值
    mutating func map<T>(_ field: inout T, key: Key, default defaultValue: T)
}

/// 字典映射 - `字段`的数据取值到`dict`
public struct EvalDictMapper<Key: Hashable, Value>: DictMapper {
    private(set) public var dict = [Key: Value]()

    public mutating func map<T>(_ field: inout T, key: Key, default defaultValue: T) {
        if let field = field as? Value {
            dict[key] = field
        } else if let defaultValue = defaultValue as? Value {
            dict[key] = defaultValue
        }
    }
}

/// 字典映射 - `dict`的数据赋值到`字段`
public struct AssignDictMapper<Key: Hashable, Value>: DictMapper {
    public let dict: [Key: Value]

    public init(dict: [Key: Value] = [Key: Value]()) {
        self.dict = dict
    }

    public func map<T>(_ field: inout T, key: Key, default defaultValue: T) {
        if let val = dict[key] as? T {
            field = val
        } else {
            field = defaultValue
        }
    }
}
