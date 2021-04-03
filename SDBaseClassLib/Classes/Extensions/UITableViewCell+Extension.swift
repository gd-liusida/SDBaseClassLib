//
//  UITableViewCell+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation
import UIKit

// MARK:- 一、基本的扩展
public extension SDPOP where Base: UITableViewCell {
    
    // MARK: 返回cell所在的UITableView
    /// 返回cell所在的UITableView
    /// - Returns: cell 所在的UITableView
    func superTableView() -> UITableView? {
        for view in sequence(first: self.base.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView  {
                return tableView
            }
        }
        return nil
    }
}

