//
//  UICollectionView+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UICollectionView {
    // MARK: 1.1、移动 item
    /// 允许手势移动Item，默认不允许
    func allowsMoveItem() {
        // 长点击事件，做移动cell操作
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGestureMove))
        self.addGestureRecognizer(longPressGesture)
    }
}

extension UICollectionView {
    // MARK: 长点击事件
    @objc private func handleLongGestureMove(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        // 开始移动
        case UIGestureRecognizer.State.began:
            let point = gesture.location(in: gesture.view!)
            if let selectedIndexPath = self.indexPathForItem(at: point) {
                // 开始移动
                self.beginInteractiveMovementForItem(at: selectedIndexPath)
            }
        case UIGestureRecognizer.State.changed:
            // 移动中
            let point = gesture.location(in: gesture.view!)
            self.updateInteractiveMovementTargetPosition(point)
        case UIGestureRecognizer.State.ended:
            // 结束移动
            self.endInteractiveMovement()
        default:
            // 取消移动
            self.cancelInteractiveMovement()
        }
    }
    
}

