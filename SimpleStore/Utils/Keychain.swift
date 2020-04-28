//
//  Keychain.swift
//  SimpleStore
//
//  Created by skytoup on 2020/4/28.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// Keychain操作
internal struct Keychain {
    let service: String
    let account: String
    let group: String?
    
    /// 基础查询
    fileprivate let baseQuery: [CFString: Any]
    
    init(service: String, account: String, group: String?) {
        self.service = service
        self.account = account
        self.group = group
        
        var query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as [CFString : Any]
        if let group = group {
            query[kSecAttrAccessGroup] = group
        }
        baseQuery = query
    }
    
    /// 基础查询合并其它查询
    /// - Parameter other: 其它查询
    /// - Returns:
    fileprivate func baseQueryMerging(_ other: [CFString: Any]) -> [CFString: Any] {
        baseQuery.merging(other, uniquingKeysWith: {_, r in r})
    }
    
    /// 添加或更新
    /// - Parameter data:
    func addOrUpdate(_ data: Data) {
        let dataItem = [kSecValueData: data] as [CFString: Any]
        if SecItemUpdate(baseQuery as CFDictionary, dataItem as CFDictionary) != noErr {
            let query: [CFString: Any] = baseQueryMerging(dataItem)
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    /// 获取数据
    /// - Returns:
    func fetch() -> Data? {
        let query: [CFString: Any] = baseQueryMerging([kSecReturnData: true])
        var result: AnyObject?

        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
}
