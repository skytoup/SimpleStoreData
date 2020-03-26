# SimpleStoreData

[![CI Status](https://img.shields.io/travis/l/SimpleStoreData.svg?style=flat)](https://travis-ci.org/skytoup/SimpleStoreData)
[![codecov.io](https://codecov.io/github/skytoup/SimpleStoreData/coverage.svg?branch=master)](https://codecov.io/github/skytoup/SimpleStoreData?branch=master)
[![Version](https://img.shields.io/cocoapods/v/SimpleStoreData.svg?style=flat)](https://cocoapods.org/pods/SimpleStoreData)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/cocoapods/l/SimpleStoreData.svg?style=flat)](https://cocoapods.org/pods/SimpleStoreData)
[![Platform](https://img.shields.io/cocoapods/p/SimpleStoreData.svg?style=flat)](https://cocoapods.org/pods/SimpleStoreData)

`SimpleStoreData`一个纯Swift的框架, 为了更简单、更结构化地存储和读写数据, 提供多种数据存储方式选择(暂时只有UserDefault)。

## 支持的存储方式
- UserDefault
- ...

## 示例

请参考仓库的`Example`目录

## 使用要求
- Swift
	- 5.1
	- 5.2
- iOS 9.0+ (更低或许也可以, 但是暂未测试)
- macOS 10.13+ (更低或许也可以, 但是暂未测试)
- watchOS 5.0+ (更低或许也可以, 但是暂未测试)
- ~~tvOS(没测试过)~~

## 安装

### Cocoapods
在你的`Podfile`文件中添加

```ruby
pod 'SimpleStoreData', '0.0.2'
```

### Carthage
在你的`Cartfile`文件中添加

```
github "skytoup/SimpleStoreData" ~> 0.0.2
```

### Swift Package Manager
在你的`Package.swift`文件中添加到`dependencies`内

```swift
.package(url: "https://github.com/skytoup/SimpleStoreData", .upToNextMajor(from: "0.0.2"))
```


## 用法

#### 基本使用
场景: 存储登录用户的数据(存储到UserDefault)
> Example/Example/main.swift

定义一个用户性别的枚举, 因为`UserDefault`不支持直接存储`enum`, 所以需要实现`UDCoding`

`UserDefault`支持的存储类型:

 - String
 - Int
 - Float
 - Double
 - Bool
 - Data
 - Date
 - URL

```Swift
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
```

定义存储用户数据的字段(**重点提示: SimpleStoreItem必须使用struct实现**), 字段使用`UDMapperParam`属性包装定义, 再实现`mapValue`方法进行数据映射

```Swift
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
```

定义管理`StoreItem`的管理类(此处简单使用单例, 可根据自己的业务进行调整, `manager`也可定义更多业务方法)

```Swift
class UserManager: SimpleStoreUD<UserStoreItem> {
    static let shared = UserManager(udKey: "__User__")
    
    // 这里可以添加一些业务方法
}
```

使用演示, 修改item数据即可存自动储, 无需其它调用方法

```Swift
var userM = UserManager.shared
// 清空之前的数据
userM.ud.set(nil, forKey: userM.udKey)

// 提示: 一次性更新多个字段最好是使用方法`batchUpdate`
userM[\.name] = "sky"
print("第一次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
// 第一次修改 ["gender": 0, "age": 0, "name": sky]

userM[\.age] = 18
print("第二次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
// 第二次修改 ["name": sky, "age": 18, "gender": 0]

userM[\.gender] = .male
print("第三次修改 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
// 第三次修改 ["age": 18, "name": sky, "gender": 1]


// 批量修改字段再存储
userM.batchUpdate { item in
    item.name = "yks"
    item.age = 81
    item.gender = .female
}
print("batchUpdate \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
// batchUpdate ["age": 81, "name": yks, "gender": 2]

// 相当于重置数据
userM.item = UserStoreItem()
print("重置数据 \(userM.ud.dictionary(forKey: userM.udKey) ?? [:])")
// 重置数据 ["age": 0, "name": , "gender": 0]
```

#### Store的PropertyWrapper用法
> 详情请参考`Example/Example/main.swift`

```Swift
/// 使用`PropertyWrapper`特性`SimpleStoreUDW`实现自己的`class`或`struct`一次性包含多个`StoreItem`
class AppManager {
    static let shared = AppManager()
    
    @SimpleStoreUDW<UserStoreItem>(udKey: "__AppUser__") var user
    @SimpleStoreUDW<SettingStoreItem>(udKey: "__AppSetting__") var setting
}
```

## 开源协议(MIT)

SimpleStoreData is available under the MIT license. See the LICENSE file for more info.
