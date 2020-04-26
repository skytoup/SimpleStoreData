//
//  SimpleStoreDataUD.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/26.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// `data`作为中转, 使用`UserDefault`的简单存储
open class SimpleStoreDataUD<Item: DataStoreItem>: SimpleStoreUD<Item> {
    
    override class func initItem(with udKey: String, ud: UserDefaults) -> Item {
        let datas = ud.data(forKey: udKey) ?? Data()
        return Item(datas: datas)
    }
    
    override func didSetItem() {
        var _item = item
        let newDatas = _item.archiveData()
        ud.set(newDatas, forKey: udKey)
    }
    
}

@propertyWrapper
public class SimpleStoreDataUDW<Item: DataStoreItem>: SimpleStoreDataUD<Item> {
    
    public var wrappedValue: Item {
        get { item }
        set { item = newValue }
    }
    
}
