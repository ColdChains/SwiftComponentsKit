//
//  NavigationBar.swift
//  BaseViewController
//
//  Created by lax on 2022/9/7.
//

import UIKit
import SnapKit
import SwiftBaseKit

extension NavigationBar {
    
    public enum ItemType {
        case left
        case close
        case right
    }
    
}

public protocol NavigationBarDelegate : NSObjectProtocol {
    
    /// 点击Item
    func navigationBar(_ navigationBar: NavigationBar, didSelect item: UIButton, with itemType: NavigationBar.ItemType)
    
}

public extension NavigationBarDelegate {
    
    func navigationBar(_ navigationBar: NavigationBar, didSelect item: UIButton, with itemType: NavigationBar.ItemType) {}
    
}

open class NavigationBar: UIView {

    /// 代理
    open weak var delegate: NavigationBarDelegate?

    /// 返回按钮 默认nil
    open var leftItem: UIButton? {
        willSet {
            leftItem?.removeFromSuperview()
        }
        didSet {
            guard let leftItem = leftItem else {
                return
            }
            let w = leftItem.bounds.size.width == 0 ? buttonHeight : leftItem.bounds.size.width
            let h = leftItem.bounds.size.height == 0 ? buttonHeight : leftItem.bounds.size.height
            addSubview(leftItem)
            leftItem.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.bottom.equalTo(-(buttonHeight - h) / 2)
                make.width.equalTo(w)
                make.height.equalTo(h)
            }
            let closeItem = closeItem
            self.closeItem = closeItem
        }
    }

    /// 关闭按钮 默认nil
    open var closeItem: UIButton? {
        willSet {
            closeItem?.removeFromSuperview()
        }
        didSet {
            guard let closeItem = closeItem else {
                return
            }
            let w = closeItem.bounds.size.width == 0 ? buttonHeight : closeItem.bounds.size.width
            let h = closeItem.bounds.size.height == 0 ? buttonHeight : closeItem.bounds.size.height
            addSubview(closeItem)
            closeItem.snp.makeConstraints { make in
                make.left.equalTo(leftItem?.snp.right ?? self)
                make.bottom.equalTo(-(buttonHeight - h) / 2)
                make.width.equalTo(w)
                make.height.equalTo(h)
            }
        }
    }

    /// 右侧按钮 默认nil
    open var rightItem: UIButton? {
        willSet {
            rightItem?.removeFromSuperview()
        }
        didSet {
            guard let rightItem = rightItem else {
                return
            }
            let w = rightItem.bounds.size.width == 0 ? buttonHeight : rightItem.bounds.size.width
            let h = rightItem.bounds.size.height == 0 ? buttonHeight : rightItem.bounds.size.height
            addSubview(rightItem)
            rightItem.snp.makeConstraints { make in
                make.right.equalTo(-rightItemMargin)
                make.bottom.equalTo(-(buttonHeight - h) / 2)
                make.width.equalTo(w)
                make.height.equalTo(h)
            }
            if rightItem.allTargets.count == 0 {
                rightItem.addTarget(self, action: #selector(rightItemAction(_:)), for: .touchUpInside)
            }
        }
    }

    /// 自定义标题视图 默认nil
    open var titleView: UIView? {
        willSet {
            titleView?.removeFromSuperview()
        }
        didSet {
            guard let titleView = titleView else {
                return
            }
            addSubview(titleView)
            titleView.snp.makeConstraints { make in
                make.bottom.centerX.equalToSuperview()
                make.height.equalTo(buttonHeight)
                make.left.greaterThanOrEqualTo(closeItem?.snp.right ?? leftItem?.snp.right ?? self)
                make.right.lessThanOrEqualTo(rightItem?.snp.left ?? self)
            }
        }
    }
    
    /// 标题 默认显示
    open var titleLabel: UILabel?

    /// 分割线 默认显示
    open lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseConfig.shared.dividerColor
        return view
    }()

    /// 右侧按钮右侧的间距 默认0
    open var rightItemMargin: CGFloat = 0 {
        didSet {
            guard let rightItem = rightItem else {
                return
            }
            rightItem.snp.updateConstraints { make in
                make.right.equalTo(-rightItemMargin)
            }
        }
    }
    
    private var buttonHeight: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: NavigationBarHeight))
        
        backgroundColor = BaseConfig.shared.navigationBarColor
        buttonHeight = self.frame.size.height - StatusBarHeight
        
        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        titleLabel = UILabel(frame: CGRect(x: 11, y: 11, width: 44, height: 44))
        titleLabel?.font = BaseConfig.shared.navigationTitleFont
        titleLabel?.textColor = BaseConfig.shared.navigationTitleColor
        titleLabel?.textAlignment = .center
        titleView = titleLabel
        guard let titleView = titleView else {
            return
        }
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.left.greaterThanOrEqualTo(closeItem?.snp.right ?? leftItem?.snp.right ?? self)
            make.right.lessThanOrEqualTo(rightItem?.snp.left ?? self)
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 设置返回按钮
    open func addLeftItem() {
        let button = UIButton()
        button.titleLabel?.font = BaseConfig.shared.navigationTitleFont
        button.setTitleColor(BaseConfig.shared.navigationTitleColor, for: .normal)
        if #available(iOS 13.0, *) {
            button.setImage(BaseConfig.shared.backButtonImage ?? UIImage(named: "icon_navigation_back@3x", in: Bundle(for: NavigationBar.self), with: nil), for: .normal)
        } else {
            button.setImage(BaseConfig.shared.backButtonImage ?? UIImage(named: "icon_navigation_back@3x", in: Bundle(for: NavigationBar.self), compatibleWith: nil), for: .normal)
        }
        button.addTarget(self, action: #selector(leftItemAction(_:)), for: .touchUpInside)
        leftItem = button
    }
    
    /// 设置关闭按钮
    open func addCloseItem() {
        let button = UIButton()
        button.titleLabel?.font = BaseConfig.shared.navigationTitleFont
        if #available(iOS 13.0, *) {
            button.setImage(BaseConfig.shared.closeButtonImage ?? UIImage(named: "icon_navigation_close@3x", in: Bundle(for: NavigationBar.self), with: nil), for: .normal)
        } else {
            button.setImage(BaseConfig.shared.closeButtonImage ?? UIImage(named: "icon_navigation_close@3x", in: Bundle(for: NavigationBar.self), compatibleWith: nil), for: .normal)
        }
        button.addTarget(self, action: #selector(closeItemAction(_:)), for: .touchUpInside)
        button.isHidden = true
        closeItem = button
    }
    
    @objc private func leftItemAction(_ sender: UIButton) {
        delegate?.navigationBar(self, didSelect: sender, with: .left)
    }

    @objc private func closeItemAction(_ sender: UIButton) {
        delegate?.navigationBar(self, didSelect: sender, with: .close)
    }

    @objc private func rightItemAction(_ sender: UIButton) {
        delegate?.navigationBar(self, didSelect: sender, with: .right)
    }
    
}
