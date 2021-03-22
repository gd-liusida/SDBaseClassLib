//
//  SDNibLoadable.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//

import UIKit

public protocol SDNibLoadable {}

extension SDNibLoadable where Self: UIView {
    
    static func loadFormNib(_ name: String? = nil) -> Self {
        let loadName = name == nil ? "\(self)" : name!
        let v = Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
        return v
    }
    
}

extension SDNibLoadable where Self: UIViewController {
    
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

