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

/// 字典映射 - `字段`的数据取值到`dict`
public struct EvalUDMapper: UDMapper {
    private(set) public var dict = [Key: Value]()

    mutating public func map<T>(_ field: inout T, key: String, default defaultValue: T) {
        precondition(((T.self as? UDCoding.Type) != nil), "\(field)(\(T.self)) need impl UDCoding")
        
        dict[key] = (field as! UDCoding).toUDAny()
    }
}

/// 字典映射 - `dict`的数据赋值到`字段`
public struct AssignUDMapper: UDMapper {
    /// dict: [Key: Value]在XCode11.4编译提示`Reference to invalid associated type 'Key' of type 'AssignUDMapper'`
    /// 暂时这样写, 旧 `public let dict: [Key: Value]`
    public let dict: [String: Any]
    
    public init(dict: [Key: Value] = [Key: Value]()) {
        self.dict = dict
    }
    
    public func map<T>(_ field: inout T, key: String, default defaultValue: T) {
        precondition(((T.self as? UDCoding.Type) != nil), "\(field)(\(T.self)) need impl UDCoding")
        
        if let val = dict[key] as? T as? UDCoding {
            field = ((T.self as! UDCoding.Type).fromUDAny(val) as? T) ?? defaultValue
        } else {
            field = defaultValue
        }
    }
}
