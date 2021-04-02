//
//  SDCommonTool.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

// MARK:- 一、基本的方法
public struct SDCommonTool {
    
    // MARK: 1.1、交换两个值
    /// 交换两个值
    /// - Parameters:
    ///   - value1: 值一
    ///   - value2: 值二
    @discardableResult
    public static func swapMe<T>(value1: inout T, value2: inout T) -> (T,T) {
        (value1,value2) = (value2,value1)
        return (value1, value2)
    }
}

