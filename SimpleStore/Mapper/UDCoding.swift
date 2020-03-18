//
//  UDCoding.swift
//  SimpleStore
//
//  Created by skytoup on 2020/3/17.
//  Copyright © 2020 skytoup. All rights reserved.
//

import Foundation

/// `UserDefault`支持的`存储类型` 和 一些数据 互转
/// 为了支持`UserDefault`不支持存储的一些`class`、`struct`、`enum`, 能转换存储和读取
///
/// `UserDefault`支持的存储类型:
///     - String
///     - Int
///     - Float
///     - Double
///     - Bool
///     - Data
///     - Date
///     - URL
public protocol UDCoding {
    /// 转为`UserDefault`支持的`存储类型`, 以`Any`返回
    func toUDAny() -> Any
    /// `UserDefault`支持的`存储类型`转为其它的数据
    static func fromUDAny(_ any: Any?) -> Self?
}

/// 直接返回自身, 即自身就是`UserDefault`支持的存储类型
public protocol UDCodingJustSelf: UDCoding {
}

extension UDCodingJustSelf {
    public static func fromUDAny(_ any: Any?) -> Self? {
        any as? Self
    }
    public func toUDAny() -> Any {
        self
    }
}

/// 把`UserDefault`支持的存储类型都默认实现了返回自身
extension String: UDCodingJustSelf { }
extension Int: UDCodingJustSelf { }
extension Float: UDCodingJustSelf { }
extension Double: UDCodingJustSelf { }
extension Bool: UDCodingJustSelf { }
extension Data: UDCodingJustSelf { }
extension Date: UDCodingJustSelf { }
extension URL: UDCodingJustSelf { }

extension Array: UDCoding where Element: UDCoding { }
extension Array: UDCodingJustSelf where Element: UDCoding { }

extension Dictionary: UDCoding where Key == String, Value: UDCoding { }
extension Dictionary: UDCodingJustSelf where Key == String, Value: UDCoding { }
