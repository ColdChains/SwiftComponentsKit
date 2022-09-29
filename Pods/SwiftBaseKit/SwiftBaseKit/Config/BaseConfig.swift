//
//  BaseConfig.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation
import UIKit

public class BaseConfig {
    
    public static let shared = BaseConfig()
    
    /// 按钮高度
    public var buttonHeight: CGFloat = 44
    
    /// 间距
    public var margin: CGFloat = 16
    
    /// 行间距
    public var lineSpace: CGFloat = 4
    
    /// 圆角
    public var cornerRadius: CGFloat = 4
    
    public var bigCornerRadius: CGFloat = 8
    
    /// 网络超时时间
    public var timeoutInterval: CGFloat = 30
    
    
    /// 是否打印日志 默认false release模式不起作用
    public var logEnabled = false
    
    
    /// 导航栏标题字体 默认16
    public var navigationTitleFont  = UIFont.boldSystemFont(ofSize: 16)

    /// 导航栏按钮字体 默认14
    public var navigationButtonFont = UIFont.systemFont(ofSize: 14)
    

    /// 返回按钮图片
    public var backButtonImage: UIImage?

    /// 关闭按钮图片
    public var closeButtonImage: UIImage?
    
    
    /// 标签栏颜色 默认FFFFFF
    public var tabBarColor          = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#000000")
    
    /// 标签栏选中颜色 默认333333
    public var tabBarSelectedColor  = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 导航栏颜色 默认FFFFFF
    public var navigationBarColor   = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#000000")
    
    /// 导航栏标题颜色 默认333333
    public var navigationTitleColor = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 分割线颜色 默认F8F8F8
    public var dividerColor         = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
    /// 进度条颜色 默认blue
    public var progressColor        = UIColor.blue
    
    
    /// 文本色一
    public var blackTextColor        = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 文本色二
    public var grayTextColor        = UIColor.dynamic(hex: "#666666", darkHex: "#BBBBBB")
    
    /// 文本色三
    public var lightTextColor       = UIColor(hex: "#999999")
    
    /// 文本色四
    public var placeholderColor     = UIColor(hex: "#CCCCCC")
    

    /// 主题色
    public var themeColor           = UIColor(hex: "#F58220")
    
    /// 浅色主题色
    public var lightThemeColor      = UIColor(hex: "#FBB843")
    
    /// 高亮状态主题色
    public var highlightThemeColor  = UIColor(hex: "#FF8F2F")
    
    /// 不可用状态颜色
    public var unableColor          = UIColor(hex: "#C2C5C9")
    
    
    /// 背景颜色 默认F8F8F8
    public var backgroundColor      = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
    /// 背景颜色
    public var containerColor       = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#1B1C1E")
    
    
    /// 提示框颜色
    public var toastColor           = UIColor(hex: "#000000", alpha: 0.8)
    
    /// 蒙层颜色
    public var maskColor            = UIColor(hex: "#000000", alpha: 0.5)
    
    /// 阴影颜色
    public var shadowColor          = UIColor(hex: "#000000", alpha: 0.1)
    
}

public extension UIColor {
    
    static var blackText         = BaseConfig.shared.blackTextColor
    
    static var grayText         = BaseConfig.shared.grayTextColor
    
    static var lightText        = BaseConfig.shared.lightTextColor
    
    static var placeholder      = BaseConfig.shared.placeholderColor
    
    
    static var theme            = BaseConfig.shared.themeColor
    
    static var lightTheme       = BaseConfig.shared.lightThemeColor
    
    static var highlightTheme   = BaseConfig.shared.highlightThemeColor
    
    static var unable           = BaseConfig.shared.unableColor
    
    
    static var systemBackground = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#000000")
    
    static var background       = BaseConfig.shared.backgroundColor
    
    static var container        = BaseConfig.shared.containerColor
    
    
    static var divider          = BaseConfig.shared.dividerColor
    
    static var toast            = BaseConfig.shared.toastColor
    
    static var mask             = BaseConfig.shared.maskColor
    
    static var shadow           = BaseConfig.shared.shadowColor
    
}

