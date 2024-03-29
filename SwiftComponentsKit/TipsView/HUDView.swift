//
//  HUDView.swift
//  TipsView
//
//  Created by lax on 2022/8/4.
//

import UIKit
import SnapKit

public struct HUDViewConfig {
    
    public static var shared = HUDViewConfig()
    
    /// tag
    public var hudViewTag = 910
    
    /// 背景颜色
    public var backgroundColor = UIColor(white: 0, alpha: 0.6)
    
    /// 阴影颜色
    public var shadowColor = UIColor(white: 1, alpha: 0.02).cgColor
    
    /// 指示器颜色
    public var indicatorColor: UIColor = .white
    
    /// 圆角
    public var cornerRadius: CGFloat = 8
    
    /// 字体大小
    public var fontSize: Double = 14
    
    /// 字体颜色
    public var textColor: UIColor = .white
    
    /// 加载中的提示
    public var loadMessage = "正在加载"
    
    /// 加载缓慢提示
    public var loadSlowMessage = "加载缓慢"
    
    /// 设置加载缓慢时间 默认5s 设置0则不出现加载缓慢
    public var loadSlowTimeInterval = 5.0
    
    /// 加载缓慢颜色
    public var loadSlowColor = UIColor.orange
    
}

extension HUDView {
    
    public enum Style {
        case `default`
        case light
        case dark
    }
    
}

open class HUDView: UIView {
    
    private(set) var style: Style = .default {
        didSet {
            switch style {
            case .default:
                setStyleDefault()
            case .light:
                setStyleLight()
            case .dark:
                setStyleDark()
            }
        }
    }
    
    private(set) var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = HUDViewConfig.shared.cornerRadius
        view.layer.shadowOffset = CGSize()
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 0
        return view
    }()
    
    private(set) lazy var indicatorView: UIActivityIndicatorView = {
        let active = UIActivityIndicatorView(style: .whiteLarge)
        active.hidesWhenStopped = true
        active.startAnimating()
        return active
    }()
    
    private(set) lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: HUDViewConfig.shared.fontSize)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = HUDViewConfig.shared.hudViewTag
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension HUDView {
    
    public func show(in view: UIView?, style: Style = .default, top offset: CGFloat = 0, message: String?) {
        guard let _ = view else { return }
        view!.viewWithTag(HUDViewConfig.shared.hudViewTag)?.removeFromSuperview()
        view!.addSubview(self)
        
        var rect = view!.frame
        rect.origin.y = offset
        rect.size.height -= offset
        frame = rect
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-offset / 2)
        }
        
        contentView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.left.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(indicatorView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        tipsLabel.text = message
        self.style = style
        
        if (HUDViewConfig.shared.loadSlowTimeInterval > 0) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + HUDViewConfig.shared.loadSlowTimeInterval) {
                self.loadSlow()
            }
        }
    }
    
    public func hide() {
        removeFromSuperview()
    }
    
    private func loadSlow() {
        indicatorView.color = HUDViewConfig.shared.loadSlowColor
        tipsLabel.textColor = HUDViewConfig.shared.loadSlowColor
        tipsLabel.text = HUDViewConfig.shared.loadSlowMessage
    }
    
    private func setStyleDefault() {
        contentView.backgroundColor = HUDViewConfig.shared.backgroundColor
        contentView.layer.shadowColor = HUDViewConfig.shared.shadowColor
        indicatorView.color = HUDViewConfig.shared.indicatorColor
        tipsLabel.textColor = HUDViewConfig.shared.textColor
    }
    
    private func setStyleLight() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        contentView.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        indicatorView.color = .darkGray
        tipsLabel.textColor = .lightGray
    }
    
    private func setStyleDark() {
        contentView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        contentView.layer.shadowColor = UIColor(white: 1, alpha: 0.02).cgColor
        indicatorView.color = .white
        tipsLabel.textColor = .white
    }

}

extension HUDView {
    
    /// 开始动画
    /// - Parameter view: 目标视图
    /// - Parameter message: 提示文字
    public static func show(in view: UIView? = UIApplication.shared.keyWindow, message: String? = HUDViewConfig.shared.loadMessage) {
        view?.showHUD(message)
    }
    
    /// 结束动画
    public static func hide() {
        UIApplication.shared.keyWindow?.hideHUD()
    }
    
}

extension UIView {
    
    /// 开始动画
    /// - Parameter message: 提示文字
    public func showHUD(_ message: String? = HUDViewConfig.shared.loadMessage) {
        if let hudView = viewWithTag(HUDViewConfig.shared.hudViewTag) as? HUDView {
            bringSubviewToFront(hudView)
        } else {
            let hudView = HUDView()
            hudView.show(in: self, message: message)
        }
    }
    
    /// 结束动画
    public func hideHUD() {
        viewWithTag(HUDViewConfig.shared.hudViewTag)?.removeFromSuperview()
    }
    
}
