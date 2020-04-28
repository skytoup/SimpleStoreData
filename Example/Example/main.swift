//
//  main.swift
//  Example
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation
import SimpleStore

struct FavouriteItem: CodableDictStoreItem, CodableDataStoreItem {
    var cat: String?
    var dog = ""
}

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
struct UserStoreItem: UDMapperStoreItem {
    @UDMapperParam(key: "name", default: "") var name
    @UDMapperParam(key: "age", default: 0) var age
    @UDMapperParam(key: "gender", default: Gender.unknown) var gender
    
    mutating func mapValue<Mapper>(_ mapper: inout Mapper) where Mapper : DictMapper, Key == Mapper.Key, Value == Mapper.Value {
        mapper <- _name
        mapper <- _age
        mapper <- _gender
    }
}

struct SettingStoreItem: UDMapperStoreItem {
    @UDMapperParam(key: "enableDark", default: false) var isEnableDark
    
    mutating func mapValue<Mapper>(_ mapper: inout Mapper) where Mapper : DictMapper, Self.Key == Mapper.Key, Self.Value == Mapper.Value {
        mapper <- _isEnableDark
    }
}

class UserManager: StoreDictUD<UserStoreItem> {
    static let shared = UserManager(udKey: "__User__")
    
    // 这里可以添加一些业务方法
}

/// 使用`PropertyWrapper`特性`SimpleStoreUDW`实现自己的`class`或`struct`一次性包含多个`StoreItem`
class AppManager {
    static let shared = AppManager()
    
    @StoreDictUDW<UserStoreItem>(udKey: "__AppUser__") var user
    @StoreDictUDW<SettingStoreItem>(udKey: "__AppSetting__") var setting
    @StoreDictUDW<FavouriteItem>(udKey: "__AppFavourite__") var favourite
    @StoreDataUDW<FavouriteItem>(udKey: "__AppFavouriteData__") var favouriteData
    
    @StoreKeychainW<FavouriteItem>(service: "test", account: "test") var favouriteKc
}

func cleanDatas() {
    print("打印一下上次运行之后的数据")
    print("UserManager \(UserManager.shared.ud.dictionary(forKey: UserManager.shared.udKey) ?? [:])")
    print("AppManager user \(UserDefaults.standard.dictionary(forKey: "__AppUser__") ?? [:])")
    print("AppManager setting \(UserDefaults.standard.dictionary(forKey: "__AppSetting__") ?? [:])")
    print("AppManager favourite \(UserDefaults.standard.dictionary(forKey: "__AppFavourite__") ?? [:])")
    print("AppManager favourite data \(UserDefaults.standard.data(forKey: "__AppFavouriteData__") ?? Data())")
    
    print("清空上次运行的数据")
    UserManager.shared.item = .init()
    AppManager.shared.user = .init()
    AppManager.shared.setting = .init()
    AppManager.shared.favourite = .init()
    AppManager.shared.favouriteData = .init()
//    AppManager.shared.favouriteKc = .init()
}

func example_0() {
    print("\n\n----- \(#function)开始 -----\n")
    
    var userM = UserManager.shared

    // 提示: 一次性更新多个字段最好是使用方法`batchUpdate`
    userM[\.name] = "sky"
    print("第一次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

    userM[\.age] = 18
    print("第二次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

    userM[\.gender] = .male
    print("第三次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")


    // 相当于重置数据
    userM.item = UserStoreItem()
    print("重置数据 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
    
    
    // 批量修改字段再存储
    userM.batchUpdate { item in
        item.name = "yks"
        item.age = 81
        item.gender = .female
    }
    print("batchUpdate \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")

    print("\n----- \(#function)结束 -----\n\n")
}

func example_1() {
    print("\n\n----- \(#function)开始 -----\n")
    
    let am = AppManager.shared
    
    print("user修改前 \(UserDefaults.standard.dictionary(forKey: "__AppUser__") ?? [:])")
    am.user.age = 1024
    print("user修改后 \(UserDefaults.standard.dictionary(forKey: "__AppUser__") ?? [:])")
    
    
    print("setting修改前 \(UserDefaults.standard.dictionary(forKey: "__AppSetting__") ?? [:])")
    am.setting.isEnableDark = true
    print("setting修改后 \(UserDefaults.standard.dictionary(forKey: "__AppSetting__") ?? [:])")
    
    
    print("favourite修改前 \(UserDefaults.standard.dictionary(forKey: "__AppFavourite__") ?? [:])")
    am.favourite.cat = "world"
    am.favourite.dog = "hello"
    print("favourite修改后 \(UserDefaults.standard.dictionary(forKey: "__AppFavourite__") ?? [:])")
    
    
    print("favourite data修改前 \(UserDefaults.standard.data(forKey: "__AppFavouriteData__") ?? Data())")
    am.favouriteData.cat = "world data"
    am.favouriteData.dog = "hello data"
    print("favourite data修改后 \(UserDefaults.standard.data(forKey: "__AppFavouriteData__") ?? Data())")
    
    print("favourite kc data修改前 \(am.favouriteKc)")
    am.favouriteKc.cat = "kc workd data"
    am.favouriteKc.dog = "kc hello data"
    
    print("\n----- \(#function)结束 -----\n\n")
}


cleanDatas()
example_0()
example_1()
