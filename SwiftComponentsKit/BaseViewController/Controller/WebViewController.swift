//
//  WebViewController.swift
//  SwiftViewController
//
//  Created by lax on 2022/9/8.
//

import UIKit
import WebKit
import SwiftBaseKit

open class WebViewController: ViewController {
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }

    /// 链接地址
    open var urlString = ""

    /// 标题
    open var titleString = ""

    /// 是否取Web页面内的标题 默认false
    open var autoTitle = false {
        didSet {
            if !isViewLoaded {
                return
            }
            if !showNavigationBar {
                return
            }
            if autoTitle {
                navigationBar?.addCloseItem()
            } else {
                navigationBar?.closeItem = nil
            }
        }
    }

    /// webView顶部间距 默认导航栏的高度
    open var webViewTopMargin: CGFloat = NavigationBarHeight {
        didSet {
            if !isViewLoaded {
                return
            }
            if let _ = webView.superview {
                webView.snp.updateConstraints { make in
                    make.top.equalTo(webViewTopMargin)
                }
            }
            if let _ = progressView.superview {
                progressView.snp.updateConstraints { make in
                    make.top.equalTo(webViewTopMargin)
                }
            }
        }
    }
    
    /// 自动计算滚动视图的内容边距 默认false
    open var scrollViewAdjustmentNever = false {
        didSet {
            if #available(iOS 11.0, *) {
                webView.scrollView.contentInsetAdjustmentBehavior = scrollViewAdjustmentNever ? .never : .automatic
            }
        }
    }
    
    open var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    
    open lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.minimumFontSize = 12
        
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        config.allowsInlineMediaPlayback = true
        config.preferences = preferences
        
        let webView = WKWebView(frame: view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self;
        webView.isOpaque = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    open lazy var progressView: ProgressView = {
        return ProgressView()
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        showNavigationBar = true
        webViewTopMargin = NavigationBarHeight
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar = super.showNavigationBar
        let webViewTopMargin = webViewTopMargin
        self.webViewTopMargin = webViewTopMargin
        let autoTitle = autoTitle
        self.autoTitle = autoTitle
        navigationBar?.titleLabel?.text = titleString
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(webViewTopMargin)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(webViewTopMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        let scrollViewAdjustmentNever = scrollViewAdjustmentNever
        self.scrollViewAdjustmentNever = scrollViewAdjustmentNever
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        reloadData()
        
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if let value = change?[.newKey] {
                print(value)
            }
            break
        case "title":
            if autoTitle {
                navigationBar?.titleLabel?.text = webView.title
            }
            break
        case "canGoBack":
            if autoTitle {
                disablePopGestureRecognizer = webView.canGoBack
                navigationBar?.closeItem?.isHidden = !webView.canGoBack
            }
            break
        default:
            break
        }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let _ = navigationBar else {
                return
            }
        if UIDevice.current.orientation == .portrait {
            navigationBar?.snp.updateConstraints({ make in
                make.height.equalTo(NavigationBarHeight)
            })
        } else {
            navigationBar?.snp.updateConstraints({ make in
                make.height.equalTo(44)
            })
        }
    }
    
    open func reloadData() {
        var encode = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? urlString
        encode = encode.replacingOccurrences(of: "/%23", with: "/#")
        guard let url = URL(string: encode) else {
                return
            }
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 30)
        if request.url?.absoluteString.count ?? 0 > 0 {
            webView.load(request)
        }
    }
    
    open override func backAction() {
        if autoTitle && webView.canGoBack {
            webView.goBack()
        } else {
            super.backAction()
        }
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
            let scheme = url.scheme,
            scheme == "tel", let resourceSpecifier = (url as NSURL).resourceSpecifier {
            guard let url = URL(string: "telprompt://" + resourceSpecifier) else {
                return
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        decisionHandler(.allow)
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        if BaseConfig.shared.logEnabled {
            printLog()
        }
    }
    
}

extension WebViewController: WKScriptMessageHandler {
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        if BaseConfig.shared.logEnabled {
            printLog(message.body)
        }
    }
}

extension WebViewController: WKUIDelegate {
    
    open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return webView
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: .none, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            completionHandler()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: .none, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { _ in
            completionHandler(false)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: .none, message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { _ in
            completionHandler(nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}
