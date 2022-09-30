//
//  NavigationController.swift
//  SwiftViewController
//
//  Created by lax on 2022/9/7.
//

import UIKit

open class NavigationController: UINavigationController {

    open override var childForStatusBarHidden: UIViewController? {
        return topViewController ?? super.childForStatusBarHidden
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController ?? super.childForStatusBarStyle
    }
    
    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        if #available(iOS 11.0, *) {
            return topViewController ?? super.childForHomeIndicatorAutoHidden
        }
        return nil
    }
    
    open override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = topViewController?.modalPresentationStyle ?? .fullScreen
    }

}
