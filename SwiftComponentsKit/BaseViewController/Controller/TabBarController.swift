//
//  TabBarController.swift
//  BaseViewController
//
//  Created by lax on 2022/9/7.
//

import UIKit
import SwiftBaseKit

open class TabBarController: UITabBarController {
    
    open override var childForStatusBarHidden: UIViewController? {
        return selectedViewController ?? super.childForStatusBarHidden
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController ?? super.childForStatusBarStyle
    }
    
    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        if #available(iOS 11.0, *) {
            return selectedViewController ?? super.childForHomeIndicatorAutoHidden
        }
        return nil
    }
    
    open override var shouldAutorotate: Bool {
        return selectedViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return selectedViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = BaseConfig.shared.tabBarColor
        tabBar.tintColor = BaseConfig.shared.tabBarSelectedColor
        modalPresentationStyle = viewControllers?[selectedIndex].modalPresentationStyle ?? .fullScreen
    }

}
