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
    
    open var urlString = ""
    
    open var url: URL?
    
    open var request: URLRequest?
    
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
            updateView()
        }
    }
    
    /// 横屏webView顶部间距 默认44
    open var landscapeScreenWebViewTopMargin: CGFloat = 44 {
        didSet {
            updateView()
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
    
    /// 缓存策略
    open var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    
    /// 超时时间 默认30s
    open var timeoutInterval: TimeInterval = 30
    
    /// 显示进度条 默认true
    open var showProgress = true
    
    open var webViewConfiguration: WKWebViewConfiguration?
    
    open lazy var webView: WKWebView = {
        
        let webView: WKWebView!
        
        if let config = webViewConfiguration {
            webView = WKWebView(frame: view.bounds, configuration: config)
        } else {
            
            let preference = WKPreferences()
            // 最小字体大小 当将javaScriptEnabled属性设置为false时，可以看到明显的效果
            preference.minimumFontSize = 0
            // 设置是否支持javaScript 默认是支持的
            preference.javaScriptEnabled = true
            // 设置是否允许不经过用户交互由javaScript自动打开窗口
            preference.javaScriptCanOpenWindowsAutomatically = true

            let config = WKWebViewConfiguration()
            config.preferences = preference

            // 设置是否将网页内容全部加载到内存后再渲染
            config.suppressesIncrementalRendering = false
            // 设置HTML5视频是否允许网页播放 设置为false则会使用本地播放器
            config.allowsInlineMediaPlayback = true
            // 设置是否允许ariPlay播放
            config.allowsAirPlayForMediaPlayback = true
            // 设置视频是否需要用户手动播放  设置为false则会允许自动播放
            // config.requiresUserActionForMediaPlayback = false
            // 设置是否允许画中画技术 在特定设备上有效
            // config.allowsPictureInPictureMediaPlayback = true
            // 设置选择模式 是按字符选择 还是按模块选择
            config.selectionGranularity = .character
            // 设置请求的User-Agent信息中应用程序名称 iOS9后可用
            config.applicationNameForUserAgent = Bundle.main.name
            
            webView = WKWebView(frame: view.bounds, configuration: config)
        }
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
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        updateView()
        
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
            if let value = change?[.newKey] as? CGFloat {
                if BaseViewControllerConfig.shared.logEnabled {
                    printLog("\(keyPath ?? "") \(value)")
                }
                progressView.progress = value
                progressView.isHidden = !showProgress || value >= 1
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
        updateView()
    }
    
    private func updateView() {
        if !isViewLoaded {
            return
        }
        if let _ = webView.superview {
            webView.snp.updateConstraints { make in
                make.top.equalTo(isLandscapeScreen ? landscapeScreenWebViewTopMargin : webViewTopMargin)
            }
        }
        if let _ = progressView.superview {
            progressView.snp.updateConstraints { make in
                make.top.equalTo(isLandscapeScreen ? landscapeScreenWebViewTopMargin : webViewTopMargin)
            }
        }
    }
    
    open func reloadData(request: URLRequest? = nil) {
        var req: URLRequest?
        if let temp = request {
            req = temp
        } else if let temp = self.request {
            req = temp
        } else if let url = self.url {
            req = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        } else if let url = URL(string: urlString) {
            req = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        }
        if let temp = req, temp.url?.absoluteString.count ?? 0 > 0 {
            webView.load(temp)
        }
    }
    
    open override func navigationBarDidSelectLeftItem() {
        if autoTitle && webView.canGoBack {
            webView.goBack()
        } else {
            super.backAction()
        }
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           let scheme = url.scheme,
           scheme == "tel", let resourceSpecifier = (url as NSURL).resourceSpecifier {
            if let url = URL(string: "telprompt://" + resourceSpecifier) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        decisionHandler(.allow)
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
}

extension WebViewController: WKUIDelegate {
    
    open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
        return webView
//        if let mainFrame = navigationAction.targetFrame?.isMainFrame, !mainFrame {
//            webView.load(navigationAction.request)
//        }
//        return nil
    }
    
    public func webViewDidClose(_ webView: WKWebView) {
        if BaseViewControllerConfig.shared.logEnabled {
            printLog(#function)
        }
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: .none, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: BaseViewControllerConfig.shared.confirmText, style: .default, handler: { _ in
            completionHandler()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: .none, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: BaseViewControllerConfig.shared.confirmText, style: .default, handler: { _ in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: BaseViewControllerConfig.shared.cancelText, style: .default, handler: { _ in
            completionHandler(false)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: .none, message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: BaseViewControllerConfig.shared.confirmText, style: .default, handler: { _ in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))
        alertController.addAction(UIAlertAction(title: BaseViewControllerConfig.shared.cancelText, style: .default, handler: { _ in
            completionHandler(nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}

//extension WebViewController: WKScriptMessageHandler {
//    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print(message.body)
//        if BaseConfig.shared.logEnabled {
//            printLog(message.body)
//        }
//    }
//}
