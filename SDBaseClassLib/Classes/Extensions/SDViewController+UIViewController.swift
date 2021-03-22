//
//  SDViewController+UIViewController.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//

import UIKit

public extension UIViewController {
    
    func push(to viewController: UIViewController, animated: Bool = true) {
        if navigationController?.viewControllers.count ?? 1 > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(to viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }
    
    @discardableResult
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
   {
       if let nav = base as? UINavigationController
       {
           return currentViewController(base: nav.visibleViewController)
       }
       if let tab = base as? UITabBarController
       {
           return currentViewController(base: tab.selectedViewController)
       }
       if let presented = base?.presentedViewController
       {
           return currentViewController(base: presented)
       }
       return base
   }
}
