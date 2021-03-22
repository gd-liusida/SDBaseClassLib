//
//  SDColor+UIColor.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import UIKit

extension UIColor {
    /// 输入 十进制数 获取颜色
    class func RGBA(red r: Float, green g: Float, blue b: Float, alpha a: Float) -> UIColor {
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a))
        
    }
    
    /// 通过16进制获取对应颜色 参数格式：0xFFFFFF
    /// - Parameter netHex: 0xFFFFFF
    convenience init(netHex: UInt) {
        self.init(
            red: CGFloat((netHex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((netHex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(netHex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// 通过16进制获取对应颜色 参数格式：0xFFFFFF
    /// - Parameter netHex: 0xFFFFFF
    convenience init(netHex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((netHex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((netHex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((netHex & 0x0000FF) >> 0) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hexStr: String) {
        //处理数值
        
        var cString = hexStr.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = cString.count
        //错误处理
        
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
}

