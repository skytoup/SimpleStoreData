//
//  SimpleStore.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 简单定义存储的基本字段
public protocol SimpleStore {
    associatedtype Item

    var item: Item { get set }
}

extension SimpleStore {
    /// 通过`subscript`+`keypath`简便获取`item`的数据
    public subscript<T>(keyPath: WritableKeyPath<Item, T>) -> T {
        get {
            item[keyPath: keyPath]
        }
        set(value) {
            item[keyPath: keyPath] = value
        }
    }
}
