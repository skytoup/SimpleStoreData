//
//  StoreKeychain.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/28.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// `data`作为中转, 使用`Keychain`的简单存储
open class StoreKeychain<Item: DataStoreItem>: SimpleStore {
    
    internal let keychain: Keychain
    var service: String { keychain.service }
    var account: String { keychain.account }
    var group: String? { keychain.group }
    
    public var item: Item {
        /// `struct`修改触发`didSet`, 从而触发存储
        /// 如果`item`的类型不是`struct`, 修改item的数据无法触发`didSet`
        didSet {
            var _item = item
            let data = _item.archiveData()
            keychain.addOrUpdate(data)
        }
    }
    
    /// 初始化
    /// - Parameters:
    ///   - service: keychain的service
    ///   - account: keychain的account
    ///   - group: keychain的group
    public init(service: String, account: String, group: String? = nil) {
        keychain = Keychain(service: service, account: account, group: group)
        let data = keychain.fetch()
        self.item = Item.init(datas: data ?? Data())
    }
    
}

@propertyWrapper
public class StoreKeychainW<Item: DataStoreItem>: StoreKeychain<Item> {
    
    public var wrappedValue: Item {
        get { item }
        set { item = newValue }
    }
    
}
