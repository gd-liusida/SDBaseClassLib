//
//  SDPOP.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation
import UIKit

public struct SDPOP<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol SDPOPCompatible {}

public extension SDPOPCompatible {
    static var sd: SDPOP<Self>.Type {
        get { SDPOP<Self>.self }
        set {}
    }
    var sd: SDPOP<Self> {
        get { SDPOP(self) }
        set {}
    }
}

internal protocol SDSwiftPropertyCompatible {
    associatedtype T
    
    typealias SwiftCallBack = ((T?) -> ())
    
    var swiftCallBack: SwiftCallBack? { get set }
}
