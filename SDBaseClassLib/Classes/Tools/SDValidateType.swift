//
//  SDValidateType.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/25.
//

import UIKit

public enum SDValidateType {
    case email(_: String)
    case phone(_: String)
    case emoji(_: String)
    
    var isValid: Bool {
        var predicateStr: String!
        var currObject: String!
        switch self {
        case let .email(str):
            predicateStr = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            currObject = str
        case let .phone(str):
            predicateStr = "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"
            currObject = str
        case let .emoji(str):
            predicateStr = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
            currObject = str
            
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
}
