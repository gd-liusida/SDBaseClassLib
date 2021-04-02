//
//  SDNibLoadable.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//

import UIKit

public protocol SDNibLoadable {
    static var nib: UINib { get }
}

public extension SDNibLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}

public extension SDNibLoadable where Self: UIView {
    
    @discardableResult
    static func loadFromNib() -> Self {
        guard let v = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return v
    }
    
    @discardableResult
    static func loadFormNib(_ name: String? = nil) -> Self {
        let loadName = name == nil ? "\(self)" : name!
        let v = Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
        return v
    }
    
}

public extension SDNibLoadable where Self: UIViewController {
    
    @discardableResult
    static func loadFromStoryboard(_ name: String? = nil, with identifier: String? = nil) -> Self {
        let loadName = name == nil ? "\(self)" : name!
        guard let sdId = identifier else {
            let vc = UIStoryboard(name: loadName, bundle: nil).instantiateInitialViewController() as! Self
            return vc
        }
        let vc = UIStoryboard(name: loadName, bundle: nil).instantiateViewController(withIdentifier: sdId) as! Self
        return vc
    }
    
}

