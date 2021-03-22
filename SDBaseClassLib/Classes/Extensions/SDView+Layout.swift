//
//  SDView+Layout.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import UIKit

extension UIView {
    
    var sd_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
    }
    
    var sd_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var sd_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        
    }
    
    var sd_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }

    var sd_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var sd_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var sd_center: CGPoint {
        get {
            return self.center
        }
        set {
            self.center = newValue
        }
    }
    
    var sd_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint.init(x: newValue, y: self.center.y)
        }
    }
    
    var sd_centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint.init(x: self.center.x, y: newValue)
        }
    }
    
    var sd_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var sd_size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}
