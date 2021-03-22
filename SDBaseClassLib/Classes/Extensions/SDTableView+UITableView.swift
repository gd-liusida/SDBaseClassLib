//
//  SDTableView+UITableView.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/23.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    func setTableViewFooterBlank() {
        tableFooterView = UIView()
        separatorStyle = .none
        showsVerticalScrollIndicator = false
    }
    
}
