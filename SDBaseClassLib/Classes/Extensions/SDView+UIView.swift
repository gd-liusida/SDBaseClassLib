//
//  SDView+UIView.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    @discardableResult
    func setCornerRadius(_ cornerRaidus: CGFloat, maskToBounds: Bool = true) -> Self {
        layer.masksToBounds = maskToBounds
        layer.cornerRadius = cornerRaidus
        return self
    }
    
    @discardableResult
    func setBorderWidth(_ borderWidth: CGFloat) -> Self {
        layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func setBorderColor(_ borderColor: UIColor?) -> Self {
        layer.borderColor = borderColor?.cgColor
        return self
    }
}
