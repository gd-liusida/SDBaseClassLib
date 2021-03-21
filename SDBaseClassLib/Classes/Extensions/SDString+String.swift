//
//  SDString+String.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

public extension String {
    /// String To Int
    var toInt: Int {
        if let number = NumberFormatter().number(from: self) {
            return number.intValue
        }
        return 0
    }
    
    /// String To Float
    var toFloat: Float {
        if let number = NumberFormatter().number(from: self) {
            return number.floatValue
        }
        return 0.0
    }
    
    /// String To Double
    var toDouble: Double {
        if let number = NumberFormatter().number(from: self) {
            return number.doubleValue
        }
        return 0.0
    }
    
    /// Strung To Number
    var toNumber: NSNumber {
        if let number = NumberFormatter().number(from: self) {
            return number
        }
        return 0.0
    }
    
    /// url编码为合法的url
    var urlEncoded: String? {
        let encodeUrlStr = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return encodeUrlStr
    }
    
    /// 将编码后的url转换回原始的url
    var urlDecoded: String? {
        return self.removingPercentEncoding
    }
    
    /// sha 256 加密
    var sha256: String {
        if let data = self.data(using: .utf8) {
            return data.sha256
        }
        return ""
    }
    
    /// md 5 加密码
    var md5: String {
        if let data = self.data(using: .utf8) {
            return data.md5
        }
        return ""
    }
    
    
}
