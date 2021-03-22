//
//  SDConstans.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation
import UIKit

public let screenWidth = UIScreen.main.bounds.width  // 屏幕宽度
public let screenHeight = UIScreen.main.bounds.height // 屏幕高度
public let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height // 状态栏高度
public let navHeight: CGFloat = statusBarHeight + 44   // 导航栏高
public let tabbarHeight: CGFloat = 49  // 底部tabbar高度
public let isIphoneX = screenHeight >= 812   // 判断iPhonex
public let safeArea: CGFloat = isIphoneX ? 34 : 0  // iPhoneX 底部安全区
