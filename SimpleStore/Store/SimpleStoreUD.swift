//
//  SimpleStoreUD.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/26.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`UserDefault`的简单存储
/// 不可直接使用, 其实是相当于抽象类
open class SimpleStoreUD<Item: StoreItem>: SimpleStore {
    public let ud: UserDefaults
    public let udKey: String
    
    /// 存储的数据项
    /// 每次修改都会触发存储
    /// 如果需要一次性修改数据项的多个字段, 建议使用batchUpdate
    public var item: Item {
        /// `struct`修改触发`didSet`, 从而触发存储
        /// 如果`item`的类型不是`struct`, 修改item的数据无法触发`didSet`
        didSet {
            didSetItem()
        }
    }
    
    /// 初始化一个Item, 需要子类实现
    /// - Parameters:
    ///   - key: UserDefault key
    ///   - ud: user default
    /// - Returns:
    class func initItem(with udKey: String, ud: UserDefaults) -> Item {
        fatalError("need subclass implement")
    }
    
    /// 初始化
    /// - Parameters:
    ///   - ud: 存储使用的UserDefault, 默认为`.standard`
    ///   - udKey: `UserDefault`存储的`key`, 不能为空字符
    public init(_ ud: UserDefaults = .standard, udKey: String) {
        precondition(!udKey.isEmpty, "udKey is empty")
        
        self.ud = ud
        self.udKey = udKey
        
        item = Self.initItem(with: udKey, ud: ud)
        assert(Mirror(reflecting: item).displayStyle == .struct, "item need is a struct")
    }
    
    /// Item数据变更
    func didSetItem() {
    }
    
    /// 批量更新`item`的数据
    /// - Parameter block:
    public func batchUpdate(_ block: (_ item: inout Item) -> Void) {
        var _item = item
        block(&_item)
        item = _item
    }

}
