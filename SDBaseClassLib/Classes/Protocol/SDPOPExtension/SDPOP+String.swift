//
//  SDPOP+String.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

extension String: SDPOPCompatible {}
extension NSString: SDPOPCompatible {}

extension SDPOP where Base: ExpressibleByStringLiteral {
    
    func numberCount() -> Int {
        let string = base as! String
        var count = 0
        for c in string where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
}
