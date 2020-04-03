//
//  UDSimpleStore.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`UserDefault`的简单存储
open class SimpleStoreUD<Item: SimpleStoreUDItem>: SimpleStore {
    public let ud: UserDefaults
    public let udKey: String
    
    /// 存储的数据项
    /// 每次修改都会触发存储
    /// 如果需要一次性修改数据项的多个字段, 建议使用batchUpdate
    public var item: Item {
        /// `struct`修改触发`didSet`, 从而触发存储
        /// 如果`item`的类型不是`struct`, 修改item的数据无法触发`didSet`
        didSet {
            let newDatas = item.archive()
            ud.set(newDatas, forKey: udKey)
        }
    }
    
    /// 初始化
    /// - Parameters:
    ///   - ud: 存储使用的UserDefault, 默认为`.standard`
    ///   - udKey: `UserDefault`存储的`key`, 不能为空字符
    public init(_ ud: UserDefaults = .standard, udKey: String) {
        precondition(!udKey.isEmpty, "udKey is empty")
        
        self.ud = ud
        self.udKey = udKey
        item = Item(datas: ud.dictionary(forKey: udKey) ?? [:])
        
        assert(Mirror(reflecting: item).displayStyle == .struct, "item need is a struct")
    }
    
    /// 批量更新`item`的数据
    /// - Parameter block:
    public func batchUpdate(_ block: (_ item: inout Item) -> Void) {
        var _item = item
        block(&_item)
        item = _item
    }
}

@propertyWrapper
public class SimpleStoreUDW<Item: SimpleStoreUDItem>: SimpleStoreUD<Item> {
    
    public var wrappedValue: Item {
        get {
            item
        }
        set {
            item = newValue
        }
    }
    
}
