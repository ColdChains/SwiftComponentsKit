//
//  ViewController.swift
//  SwiftViewController
//
//  Created by lax on 2022/9/7.
//

import UIKit
import SnapKit
import SwiftBaseKit

open class ViewController: UIViewController {
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    open override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /// 是否显示自定义导航栏 默认false
    open var navigationBar: NavigationBar?

    /// 是否显示导航栏 默认false
    open var showNavigationBar = false {
        didSet {
            if !isViewLoaded {
                return
            }
            if showNavigationBar {
                navigationBar?.removeFromSuperview()
                let bar = NavigationBar()
                bar.delegate = self
                bar.addLeftItem()
                view.addSubview(bar)
                bar.snp.makeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(StatusBarHeight + 44)
                }
                navigationBar = bar
            } else if let _ = navigationBar {
                navigationBar?.removeFromSuperview()
                navigationBar = nil
            }
        }
    }

    /// 是否显示系统导航栏 默认false
    open var showSystemNavagationBar = false

    /// 是否禁用侧滑返回 默认false
    open var disablePopGestureRecognizer = false {
        didSet {
            if !isViewLoaded {
                return
            }
            navigationController?.interactivePopGestureRecognizer?.isEnabled = disablePopGestureRecognizer
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        view.backgroundColor = BaseConfig.shared.backgroundColor
        let showNavigationBar = showNavigationBar
        self.showNavigationBar = showNavigationBar
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = !showSystemNavagationBar
        if BaseConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if disablePopGestureRecognizer {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = !disablePopGestureRecognizer
        }
        if BaseConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if disablePopGestureRecognizer {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        if BaseConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if BaseConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    deinit {
        if BaseConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open var isPresent: Bool {
        if let _ = presentingViewController {
            return false
        }
        if navigationController?.viewControllers.count ?? 0 > 1 {
            return false
        }
        return true
    }
    
    open func backAction() {
        if isPresent {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc open func navigationBarDidSelectLeftItem() {
        backAction()
    }
    
    @objc open func navigationBarDidSelectCloseItem() {
        backAction()
    }
    
    @objc open func navigationBarDidSelectRightItem() {
        
    }
    
}

extension ViewController: NavigationBarDelegate {
    
    open func navigationBar(_ navigationBar: NavigationBar, didSelect item: UIButton, with itemType: NavigationBar.ItemType) {
        switch itemType {
        case .left:
            navigationBarDidSelectLeftItem()
            break
        case .close:
            navigationBarDidSelectCloseItem()
            break
        case .right:
            navigationBarDidSelectRightItem()
            break
        }
    }

}

extension NSObject {
    
    func printLog(_ any: Any? = nil) {
        #if DEBUG
            print("\(self) \(any ?? "")")
        #endif
    }
    
}
