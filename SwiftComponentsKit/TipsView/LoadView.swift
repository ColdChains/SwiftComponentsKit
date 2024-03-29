//
//  LoadView.swift
//  TipsView
//
//  Created by lax on 2022/8/4.
//

import UIKit
import SnapKit

public struct LoadViewConfig {
    
    public static var shared = LoadViewConfig()
    
    /// tag
    public var loadViewTag = 900
    
    /// 指示器颜色
    public var indicatorColor: UIColor = .lightGray
    
    /// 字体大小
    public var fontSize: Double = 14
    
    /// 字体颜色
    public var textColor: UIColor = .darkGray
    
    /// 加载中的提示
    public var loadMessage = "正在加载"
    
    /// 空数据的提示
    public var nodataMessage = "暂无数据"
    
    /// 空数据的图片
    public var nodataImage: UIImage?
    
    /// 加载失败的提示
    public var errorMessage = "加载失败了，请稍后再试"
    
    /// 加载失败的图片
    public var errorImage: UIImage?
    
    /// 图片的竖向偏移量
    public var imageViewOffSetY: CGFloat = 0
    
}

extension LoadView {
    
    public enum Status {
        case none
        case loading
        case nodata
        case error
    }
    
}

open class LoadView: UIView {
    
    fileprivate(set) var loadMessage: String?
    
    fileprivate(set) var nodataMessage: String?
    fileprivate(set) var nodataImage: UIImage?
    
    fileprivate(set) var errorMessage: String?
    fileprivate(set) var errorImage: UIImage?
    fileprivate(set) var reloadClosure: (() -> Void)?
    
    fileprivate(set) var status: Status = .none {
        didSet {
            switch status {
            case .loading:
                indicatorView.isHidden = false
                imageView.isHidden = true
                tipsLabel.text = loadMessage
                tipsLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(indicatorView.snp.bottom).offset(16)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                }
            case .error:
                indicatorView.isHidden = true
                imageView.isHidden = false
                imageView.image = errorImage
                tipsLabel.text = errorMessage
                tipsLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(imageView.snp.bottom).offset(16)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                }
            case .nodata:
                indicatorView.isHidden = true
                imageView.isHidden = false
                imageView.image = nodataImage
                tipsLabel.text = nodataMessage
                tipsLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(imageView.snp.bottom).offset(16)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                }
            default:
                break
            }
        }
    }
    
    fileprivate(set) var imageViewOffSetY: CGFloat = -16 {
        didSet {
            if imageView.superview == nil { return }
            imageView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(imageViewOffSetY)
            }
        }
    }
    
    private(set) lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(reloadAction))
        return tap
    }()
    
    private(set) lazy var indicatorView: UIActivityIndicatorView = {
        let active = UIActivityIndicatorView()
        active.color = LoadViewConfig.shared.indicatorColor
        active.hidesWhenStopped = true
        active.startAnimating()
        return active
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = LoadViewConfig.shared.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LoadViewConfig.shared.fontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = LoadViewConfig.shared.loadViewTag
        addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension LoadView {
    
    /// 加载视图
    /// - Parameters:
    ///   - view: 父视图
    ///   - status: 加载状态
    ///   - top: 距父视图顶部距离
    ///   - load: 加载中的文字
    ///   - error: 加载失败文字
    ///   - errorImage: 加载失败图片
    ///   - nodata: 空数据文字
    ///   - nodataImage: 空数据图片
    public func show (
        in view: UIView,
        status: Status = .loading,
        loadMessage: String? = nil,
        errorMessage: String? = nil,
        errorImage: UIImage? = nil,
        nodataMessage: String? = nil,
        nodataImage: UIImage? = nil
    ) {
        
        view.viewWithTag(LoadViewConfig.shared.loadViewTag)?.removeFromSuperview()
        view.addSubview(self)
        
        snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.right.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0)
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(imageViewOffSetY)
        }
        
        addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(indicatorView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.loadMessage = loadMessage
        self.errorMessage = errorMessage
        self.nodataMessage = nodataMessage
        self.errorImage = errorImage
        self.nodataImage = nodataImage
        self.status = status
    }
    
    /// 点击重新加载
    @objc private func reloadAction() {
        if status == .error && reloadClosure != nil {
            status = .loading
            reloadClosure?()
        }
    }
    
}

extension UIView {
    
    /// 开始加载动画
    /// - Parameter message: 加载提示文字
    public func loading(_ message: String? = nil) {
        if let loadView = viewWithTag(LoadViewConfig.shared.loadViewTag) as? LoadView {
            loadView.status = .loading
            loadView.tapGesture.isEnabled = false
        } else {
            let loadView = LoadView()
            loadView.show(in: self, loadMessage: message)
            loadView.tapGesture.isEnabled = false
        }
    }
    
    /// 结束加载动画
    public func endLoading() {
        viewWithTag(LoadViewConfig.shared.loadViewTag)?.removeFromSuperview()
    }
    
    /// 加载失败
    /// - Parameters:
    ///   - message: 提示文字
    ///   - image: 图片
    ///   - imageViewOffSetY: 图片竖向偏移量
    ///   - reloadClosure: 重新加载闭包
    public func endLoadingWithError(
        _ message: String? = LoadViewConfig.shared.errorMessage,
        image: UIImage? = LoadViewConfig.shared.errorImage,
        imageViewOffSetY: CGFloat = LoadViewConfig.shared.imageViewOffSetY,
        reloadClosure: (() -> Void)? = nil
    ) {
        if let loadView = viewWithTag(LoadViewConfig.shared.loadViewTag) as? LoadView {
            loadView.errorMessage = message
            loadView.errorImage = image
            loadView.status = .error
            loadView.imageViewOffSetY = imageViewOffSetY
            loadView.tapGesture.isEnabled = true
            loadView.reloadClosure = reloadClosure
        } else {
            let loadView = LoadView()
            loadView.show(in: self, status: .error, errorMessage: message, errorImage: image)
            loadView.imageViewOffSetY = imageViewOffSetY
            loadView.tapGesture.isEnabled = true
            loadView.reloadClosure = reloadClosure
        }
    }
    
    /// 暂无数据
    /// - Parameters:
    ///   - message: 提示文字
    ///   - image: 图片
    ///   - imageViewOffSetY: 图片竖向偏移量
    public func endLoadingWithNoData(
        _ message: String? = LoadViewConfig.shared.nodataMessage,
        image: UIImage? = LoadViewConfig.shared.nodataImage,
        imageViewOffSetY: CGFloat = LoadViewConfig.shared.imageViewOffSetY
    ) {
        if let loadView = viewWithTag(LoadViewConfig.shared.loadViewTag) as? LoadView {
            loadView.nodataMessage = message
            loadView.nodataImage = image
            loadView.status = .nodata
            loadView.imageViewOffSetY = imageViewOffSetY
        } else {
            let loadView = LoadView()
            loadView.show(in: self, status: .nodata, nodataMessage: message, nodataImage: image)
            loadView.imageViewOffSetY = imageViewOffSetY
        }
        if let loadView = viewWithTag(LoadViewConfig.shared.loadViewTag) as? LoadView {
            sendSubviewToBack(loadView)
        }
    }
    
}
