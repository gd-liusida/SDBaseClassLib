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
    
    /// 根据下标获取某个下标字符
    subscript(of index: Int) -> String {
        if index < 0 || index >= self.count{
            return ""
        }
        for (i,item) in self.enumerated(){
            if index == i {
                return "\(item)"
            }
        }
        return ""
    }
    /// 根据range获取字符串 a[1...3]
    subscript(r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[0..<2]
    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[start..<end])
    }
    /// 根据range获取字符串 a[...2]
    subscript(r: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[startIndex...end])
    }
    /// 根据range获取字符串 a[0...]
    subscript(r: PartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[..<3]
    subscript(r: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[startIndex..<end])
    }
    /// 截取字符串: index 开始到结尾
    /// - Parameter index: 开始截取的index
    /// - Returns: string
    func subString(_ index: Int) -> String {
        guard index < count else {
            return ""
        }
        let start = self.index(endIndex, offsetBy: index - count)
        return String(self[start..<endIndex])
    }
    
    /// 截取字符串
    /// - Parameters:
    ///   - begin: 开始截取的索引
    ///   - count: 需要截取的个数
    /// - Returns: 字符串
    func substring(start: Int, _ count: Int) -> String {
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
    
}

public extension String {
    func autoStringWidth(_ font: UIFont, height: CGFloat = 50) -> CGFloat {
        let att = [
            NSAttributedString.Key.font: font
        ]
        let str: NSString = self as NSString
        let size = str.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height),
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: att,
                                    context: nil).size
        return ceil(size.width) + 1
    }
    
    func autoStringHeight(_ font: UIFont, width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
        let att = [
            NSAttributedString.Key.font: font,
        ]
        let str: NSString = self as NSString
        let size = str.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)),
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: att,
                                    context: nil).size
        return ceil(size.height) + 1
    }
    
    func autoAttStringHeight(_ font: UIFont, width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 3
        let att = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        let str: NSString = self as NSString
        let size = str.boundingRect(with: CGSize.init(width: width,
                                                      height: CGFloat(MAXFLOAT)),
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: att,
                                    context: nil).size
        return ceil(size.height) + 1
    }
}
