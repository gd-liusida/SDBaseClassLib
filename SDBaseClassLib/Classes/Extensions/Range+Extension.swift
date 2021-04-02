//
//  Range+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation

// MARK:- 一、基本的扩展
extension Range: SDPOPCompatible {}

public extension SDPOP where Base: RangeExpression, Base.Bound == String.Index {
    
    // MARK: 1.1、Range 转 NSRange
    /// Range 转 NSRange
    /// - Parameter string: 父字符串
    /// - Returns: NSRange
    func toNSRange<S: StringProtocol>(in string: S) -> NSRange {
        return NSRange(self.base, in: string)
    }
}
