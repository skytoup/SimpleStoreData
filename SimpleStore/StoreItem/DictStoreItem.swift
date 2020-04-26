//
//  SimpleStoreDictItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/25.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`dict`的存储数据项
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol DictStoreItem: StoreItem {
    /// `dict`的`key`类型
    associatedtype Key: Hashable
    /// `dict`的`value`类型
    associatedtype Value
    
    /// 使用一些数据初始化
    /// - Parameter datas: 初始化的数据
    init(datas: [Key: Value])
    
    /// 把`Item`的数据转为`数据`
    mutating func archiveDict() -> [Key: Value]
}
