//
//  CodableDataItem.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/26.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// 使用`Data`存储, `Codable`映射的数据项
///
/// !!!注意: **必须使用struct实现, 使用class实现会使自动存储功能失效**
public protocol CodableDataStoreItem: DataStoreItem, Codable {
}

extension CodableDataStoreItem {
    public init(datas: Data) {
        if let data = try? JSONDecoder().decode(Self.self, from: datas) {
            self = data
        } else {
            self.init()
        }
    }
    
    public func archiveData() -> Data {
        if let data = try? JSONEncoder().encode(self) {
            return data
        } else {
            return .init()
        }
    }
}
