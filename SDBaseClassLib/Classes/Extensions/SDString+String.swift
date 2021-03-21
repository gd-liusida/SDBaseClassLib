//
//  SDString+String.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

extension String {
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
}
