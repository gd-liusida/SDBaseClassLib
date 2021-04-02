//
//  SDClosure.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation

/// View的闭包
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
/// 手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)
/// UIControl闭包
public typealias ControlClosure = ((UIControl) ->Void)
