//
//  UDMapper.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`UserDefault`的映射
public protocol UDMapper: DictMapper where Key == String, Value == Any { }

/// 字典映射 - `字段`的数据取值到`字典`
public struct EvalUDMapper: UDMapper {
    private(set) public var dict = [Key: Value]()

    mutating public func map<T>(_ field: inout T, key: String, default defaultValue: T) {
        precondition(((T.self as? UDCoding.Type) != nil), "\(field)(\(T.self)) need impl UDCoding")
        
        dict[key] = (field as! UDCoding).toUDAny()
    }
}

/// 字典映射 - `字典`的数据赋值到`字段`
public struct AssignUDMapper: UDMapper {
    public let dict: [Key: Value]
    
    public init(dict: [Key: Value] = [Key: Value]()) {
        self.dict = dict
    }
    
    public func map<T>(_ field: inout T, key: String, default defaultValue: T) {
        precondition(((T.self as? UDCoding.Type) != nil), "\(field)(\(T.self)) need impl UDCoding")
        
        if let val = dict[key] as? UDCoding {
            field = ((T.self as! UDCoding.Type).fromUDAny(val) as? T) ?? defaultValue
        } else {
            field = defaultValue
        }
    }
}
