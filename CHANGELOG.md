# Change Log
All notable changes to this project will be documented in this file.
~~`SimpleStoreData` adheres to [Semantic Versioning](https://semver.org/).~~(暂时未稳定, 可能会改动类名、方法名等...)


## [0.1.0](https://github.com/skytoup/SimpleStoreData/releases/tag/0.1.0)
Released on 2020-04-26

#### Added
- 对`SimpleStoreDictUD`增加`CodableDictStoreItem`, 使用`Codable`协议进行序列化
- 新增`SimpleStoreDataUD`, 使用`Data`存储到`UserDefault`
- 新增`CodableDataStoreItem`, 用于`SimpleStoreDataUD `

#### Updated
- 重命名的协议
	- `SimpleStoreUDItem` -> `UDMapperStoreItem`
	- `SimpleStoreDictItem` -> `DictMapperStoreItem`
- 重命名的类
	- `SimpleStoreUD` -> `SimpleStoreDictUD`
- 重构
	- `SimpleStoreDictUD `分离出新的`SimpleStoreUD`
	- `SimpleStoreDictItem` 分离出`DictMapValue`
	- 原`SimpleStoreDictItem`实际变更为`DictMapperStoreItem `

---

## [0.0.3](https://github.com/skytoup/SimpleStoreData/releases/tag/0.0.3)
Released on 2020-04-03

#### Fixed
- UDStore初始化没有使用ud对应数据初始化item
- AssignUDMapper.map在获取字典值时, 直接转换UDCoding失败

---

## [0.0.2](https://github.com/skytoup/SimpleStoreData/releases/tag/0.0.2)
Released on 2020-03-26

#### Added
- 对Store增加propertyWrapper用法
    - 暂时不使用protocol where语法
    - 新增propertyWrapper SimpleStoreUDW, 可不用继承SimpleStoreUD, 可使一个class或struct可定义多个StoreItem, 详情请参考Example/Example/main.swift

---

## [0.0.1](https://github.com/skytoup/SimpleStoreData/releases/tag/0.0.1)
Released on 2020-03-18

#### Added
- 首个版本, 基本的UserDefault通过Dict中转存储功能
