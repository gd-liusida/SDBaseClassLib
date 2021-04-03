//
//  UITabBar+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation
import UIKit

public extension UITabBar {
    
    // MARK: 让图片和文字在iOS11下仍然保持上下排列
    /// 让图片和文字在iOS11下仍然保持上下排列
    override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
}

