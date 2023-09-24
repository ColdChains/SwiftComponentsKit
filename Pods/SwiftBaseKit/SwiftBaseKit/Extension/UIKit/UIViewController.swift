//
//  UIViewController.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UIViewController {
    
    func dismissPresentViewController() {
        var topViewController: UIViewController? = self
        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        while topViewController?.presentingViewController != nil, topViewController != self {
            topViewController = topViewController?.presentingViewController
            topViewController?.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    func presentAlertController(title: String?, message: String?, confirmText: String = "确定", confirmBlock: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmText, style: .default, handler: { _ in
            confirmBlock?()
        }))
        dismissPresentViewController()
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlertControllerWithCancel(title: String?, message: String?, cancelText: String = "取消", confirmText: String = "确定", confirmBlock: (() -> Void)?) {
        presentAlertControllerWithCancel(title: title, message: message, cancelText: cancelText, confirmText: confirmText, cancelBlock: nil, confirmBlock: confirmBlock)
    }
    
    func presentAlertControllerWithCancel(title: String?, message: String?, cancelText: String = "取消", confirmText: String = "确定", cancelBlock: (() -> Void)?, confirmBlock: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: { _ in
            cancelBlock?()
        }))
        alert.addAction(UIAlertAction(title: confirmText, style: .default, handler: { _ in
            confirmBlock?()
        }))
        dismissPresentViewController()
        present(alert, animated: true, completion: nil)
    }
    
    func presentActionSheet(title: String? = nil, message: String? = nil, items: [String], confirmBlock: ((String) -> Void)?) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for item in items {
            actionSheet.addAction(UIAlertAction(title: item, style: .default, handler: { (_) in
                confirmBlock?(item)
            }))
        }
        dismissPresentViewController()
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentActionSheetWithCancel(title: String? = nil, message: String? = nil, items: [String], cancelText: String = "取消", cancelBlock: (() -> Void)? = nil, confirmBlock: ((String) -> Void)?) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: { _ in
            cancelBlock?()
        }))
        for item in items {
            actionSheet.addAction(UIAlertAction(title: item, style: .default, handler: { (_) in
                confirmBlock?(item)
            }))
        }
        dismissPresentViewController()
        present(actionSheet, animated: true, completion: nil)
    }
    
}

public extension UIViewController {
    
    static func viewController(for className: String?) -> UIViewController? {
        if className == nil {
            return nil
        }
        let classStringName = "\(Bundle.main.name).\(className!)"
        let classType = NSClassFromString(classStringName) as? UIViewController.Type
        if let type = classType {
            let newVC = type.init()
            return newVC
        }
        return nil;
    }
    
}

public extension UIViewController {
    
    func filterViewControllers(_ classArray: [AnyClass]) {
        var nav = navigationController
        if isKind(of: UINavigationController.self)  {
            nav = self as? UINavigationController
        }
        if let viewControllers = nav?.viewControllers {
            var arr: [UIViewController] = []
            for vc in viewControllers {
                if !vc.inClassArray(classArray) || vc == self {
                    arr.append(vc)
                }
            }
            nav?.viewControllers = arr
        }
    }
    
    private func inClassArray(_ classArray: [AnyClass]) -> Bool {
        var isHave = false
        for classType in classArray {
            if self.isKind(of: classType) {
                isHave = true
                break
            }
        }
        return isHave
    }
    
}

extension UINavigationController {
    
    func containsClass(_ classType: AnyClass) -> Bool {
        for vc in viewControllers {
            if vc.isKind(of: classType) {
                return true
            }
        }
        return false
    }
    
}
