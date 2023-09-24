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
        return isLandscapeScreen
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
    
    /// 自定义导航栏
    open var navigationBar: NavigationBar?

    /// 是否显示自定义导航栏 默认false
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
                    make.height.equalTo(NavigationBarHeight)
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
    
    /// 横屏导航栏高度
    open var landscapeScreenNavagationBarHeight = 44.0
    
    /// 是否是横屏
    open var isLandscapeScreen: Bool {
        return UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        view.backgroundColor = BaseViewControllerConfig.shared.backgroundColor
        let showNavigationBar = showNavigationBar
        self.showNavigationBar = showNavigationBar
        updateView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = !showSystemNavagationBar
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if disablePopGestureRecognizer {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = !disablePopGestureRecognizer
        }
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if disablePopGestureRecognizer {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let _ = navigationBar else {
            return
        }
        updateView()
    }
    
    deinit {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    private func updateView() {
        guard let _ = navigationBar else {
            return
        }
        if isLandscapeScreen {
            navigationBar?.snp.updateConstraints({ make in
                make.height.equalTo(landscapeScreenNavagationBarHeight)
            })
        } else {
            navigationBar?.snp.updateConstraints({ make in
                make.height.equalTo(NavigationBarHeight)
            })
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
    
    public func navigationBar(_ navigationBar: NavigationBar, didSelect item: UIButton, with itemType: NavigationBar.ItemType) {
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
