//
//  main.swift
//  Example
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
import SimpleStore

enum Gender: Int {
    case unknown = 0
    case male
    case female
}
/// 对于`UserDefault`不支持的存储类型提供数据转换
extension Gender: UDCoding {
    func toUDAny() -> Any {
        rawValue
    }
    
    static func fromUDAny(_ any: Any?) -> Gender? {
        guard let any = any as? Int else {
            return nil
        }
        return Gender(rawValue: any)
    }
}

/// **重点提示: SimpleStoreItem必须使用struct实现**
struct UserStoreItem: SimpleStoreUDItem {
    @UDMapperParam(key: "name", default: "") var name
    @UDMapperParam(key: "age", default: 0) var age
    @UDMapperParam(key: "gender", default: Gender.unknown) var gender
    
    mutating func mapValue<Mapper>(_ mapper: inout Mapper) where Mapper : DictMapper, UserStoreItem.Key == Mapper.Key, UserStoreItem.Value == Mapper.Value {
        mapper <- _name
        mapper <- _age
        mapper <- _gender
    }
}

class UserManager: SimpleStoreUD<UserStoreItem> {
    static let shared = UserManager(udKey: "__User__")
    
    // 这里可以添加一些业务方法
}



var userM = UserManager.shared
// 清空之前的数据
userM.ud.set(nil, forKey: userM.udKey)

// 提示: 一次性更新多个字段最好是使用方法`batchUpdate`
userM[\.name] = "sky"
print("第一次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

userM[\.age] = 18
print("第二次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

userM[\.gender] = .male
print("第三次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")


// 批量修改字段再存储
userM.batchUpdate { item in
    item.name = "yks"
    item.age = 81
    item.gender = .female
}
print("batchUpdate \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

// 相当于重置数据
userM.item = UserStoreItem()
print("重置数据 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
