//
//  SDReusable.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//

import UIKit

public protocol SDReusable: class {
    static var reuseIdentifier: String { get }
}

public typealias SDNibReusable = SDReusable & SDNibLoadable

public extension SDReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
