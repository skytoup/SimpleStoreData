//
//  CodableDictStoreItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`dict`存储, `Codable`映射的数据项
///
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol CodableDictStoreItem: DictStoreItem, Codable where Key == String, Value == Any {
}

extension CodableDictStoreItem {
    public init(datas: [Key : Value]) {
        if let data = try? JSONSerialization.data(withJSONObject: datas, options: []), let res = (try? JSONDecoder().decode(Self.self, from: data)) {
            self = res
        } else {
            self.init()
        }
    }

    public mutating func archiveDict() -> [Key: Value] {
        if let data = try? JSONEncoder().encode(self), let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [Key: Value] {
            return dict
        } else {
            return [:]
        }
    }
    
}
