//
//  UDSimpleStore.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// `dict`作为中转, 使用`UserDefault`的简单存储
open class SimpleStoreDictUD<Item: DictStoreItem>: SimpleStoreUD<Item> {
    
    override class func initItem(with udKey: String, ud: UserDefaults) -> Item {
        let datas = (ud.dictionary(forKey: udKey) ?? [:]) as [Item.Key: Item.Value]
        return Item(datas: datas)
    }
    
    override func didSetItem() {
        var _item = item
        let newDatas = _item.archiveDict()
        ud.set(newDatas, forKey: udKey)
    }
}

@propertyWrapper
public class SimpleStoreDictUDW<Item: DictStoreItem>: SimpleStoreDictUD<Item> {
    
    public var wrappedValue: Item {
        get { item }
        set { item = newValue }
    }
    
}
