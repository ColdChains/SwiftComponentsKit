//
//  LoadView.swift
//  TipsView
//
//  Created by lax on 2022/8/4.
//

import UIKit
import SnapKit

extension LoadView {
    
    public enum Status {
        case none
        case loading
        case nodata
        case error
    }
    
}

public class LoadView: UIView {
    
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
        active.color = .lightGray
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
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = LoadView.loadViewTag
        addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension LoadView {
    
    /// ????????????
    /// - Parameters:
    ///   - view: ?????????
    ///   - status: ????????????
    ///   - top: ????????????????????????
    ///   - load: ??????????????????
    ///   - error: ??????????????????
    ///   - errorImage: ??????????????????
    ///   - nodata: ???????????????
    ///   - nodataImage: ???????????????
    public func show (
        in view: UIView,
        status: Status = .loading,
        loadMessage: String? = nil,
        errorMessage: String? = nil,
        errorImage: UIImage? = nil,
        nodataMessage: String? = nil,
        nodataImage: UIImage? = nil
    ) {
        
        view.viewWithTag(LoadView.loadViewTag)?.removeFromSuperview()
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
    
    /// ??????????????????
    @objc private func reloadAction() {
        if status == .error && reloadClosure != nil {
            status = .loading
            reloadClosure?()
        }
    }
    
}

extension LoadView {
    
    // tag
    public static var loadViewTag = 900
    
    // ??????????????????
    public static var defaultLoadMessage = "????????????"
    
    // ??????????????????
    public static var defaultNodataMessage = "????????????"
    // ??????????????????
    public static var defaultNodataImage: UIImage?
    
    // ?????????????????????
    public static var defaultErrorMessage = "?????????????????????????????????"
    // ?????????????????????
    public static var defaultErrorImage: UIImage?
    
    // ????????????????????????
    public static var defaultImageViewOffSetY: CGFloat = 0
    
}

extension UIView {
    
    /// ??????????????????
    /// - Parameter message: ??????????????????
    public func loading(_ message: String? = nil) {
        if let loadView = viewWithTag(LoadView.loadViewTag) as? LoadView {
            loadView.status = .loading
            loadView.tapGesture.isEnabled = false
        } else {
            let loadView = LoadView()
            loadView.show(in: self, loadMessage: message)
            loadView.tapGesture.isEnabled = false
        }
    }
    
    /// ??????????????????
    public func endLoading() {
        viewWithTag(LoadView.loadViewTag)?.removeFromSuperview()
    }
    
    /// ????????????
    /// - Parameters:
    ///   - message: ????????????
    ///   - image: ??????
    ///   - imageViewOffSetY: ?????????????????????
    ///   - reloadClosure: ??????????????????
    public func endLoadingWithError(_ message: String? = LoadView.defaultErrorMessage, image: UIImage? = LoadView.defaultErrorImage, imageViewOffSetY: CGFloat = LoadView.defaultImageViewOffSetY, reloadClosure: (() -> Void)? = nil) {
        if let loadView = viewWithTag(LoadView.loadViewTag) as? LoadView {
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
    
    /// ????????????
    /// - Parameters:
    ///   - message: ????????????
    ///   - image: ??????
    ///   - imageViewOffSetY: ?????????????????????
    public func endLoadingWithNoData(_ message: String? = LoadView.defaultNodataMessage, image: UIImage? = LoadView.defaultNodataImage, imageViewOffSetY: CGFloat = LoadView.defaultImageViewOffSetY) {
        if let loadView = viewWithTag(LoadView.loadViewTag) as? LoadView {
            loadView.nodataMessage = message
            loadView.nodataImage = image
            loadView.status = .nodata
            loadView.imageViewOffSetY = imageViewOffSetY
        } else {
            let loadView = LoadView()
            loadView.show(in: self, status: .nodata, nodataMessage: message, nodataImage: image)
            loadView.imageViewOffSetY = imageViewOffSetY
        }
        if let loadView = viewWithTag(LoadView.loadViewTag) as? LoadView {
            sendSubviewToBack(loadView)
        }
    }
    
    public func endLoadingWithCount(_ count: Int) {
        
    }

}
