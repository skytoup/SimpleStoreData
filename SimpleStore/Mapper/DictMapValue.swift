//
//  DictMapValue.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 字典数据映射
public protocol DictMapValue {
    associatedtype Key = Hashable
    associatedtype Value
    
    /// 映射数据, `dict` <-> `字段`
    /// - Parameter mapper: 映射器
    mutating func mapValue<Mapper: DictMapper>(_ mapper: inout Mapper) where Mapper.Key == Key, Mapper.Value == Value
}
