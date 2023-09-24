//
//  AdapterConfig.swift
//  SwiftComponentsKit
//
//  Created by lax on 2023/9/22.
//

import Foundation
import UIKit

public struct AdapterConfig {
    
    public static var shared = AdapterConfig()
    
    /// 按钮高度
    public var buttonHeight: CGFloat = 44
    
    /// 间距
    public var margin: CGFloat = 16
    
    /// 行间距
    public var lineSpace: CGFloat = 4
    
    /// 圆角
    public var cornerRadius: CGFloat = 4
    
    public var bigCornerRadius: CGFloat = 8
    
    
    /// 文本色一
    public var blackTextColor        = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 文本色二
    public var grayTextColor        = UIColor.dynamic(hex: "#666666", darkHex: "#BBBBBB")
    
    /// 文本色三
    public var lightTextColor       = UIColor(hex: "#999999")
    
    /// 文本色四
    public var placeholderColor     = UIColor(hex: "#CCCCCC")
    
    
    /// 边框颜色
    public var borderColor          = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
    /// 分割线颜色
    public var dividerColor         = UIColor.dynamic(hex: "#F0F0F0", darkHex: "#000000")
    
    /// 阴影颜色
    public var shadowColor          = UIColor(hex: "#000000", alpha: 0.1)
    
    /// 蒙层颜色
    public var maskColor            = UIColor(hex: "#000000", alpha: 0.5)
    
    /// 背景颜色
    public var backgroundColor      = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
    /// 背景颜色
    public var containerColor       = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#1B1C1E")
    
    
    /// 主题色
    public var themeColor           = UIColor(hex: "#F58220")
    
    /// 浅色主题色
    public var lightThemeColor      = UIColor(hex: "#FBB843")
    
    /// 高亮状态主题色
    public var highlightThemeColor  = UIColor(hex: "#FF8F2F")
    
    /// 不可用状态颜色
    public var unableColor          = UIColor(hex: "#C2C5C9")
    
}

extension UIColor {
    
    static var blackText         = AdapterConfig.shared.blackTextColor
    
    static var grayText         = AdapterConfig.shared.grayTextColor
    
    static var lightText        = AdapterConfig.shared.lightTextColor
    
    static var placeholder      = AdapterConfig.shared.placeholderColor
    
    
    static var brder            = AdapterConfig.shared.borderColor
    
    static var divider          = AdapterConfig.shared.dividerColor
    
    static var shadow           = AdapterConfig.shared.shadowColor
        
    static var mask             = AdapterConfig.shared.maskColor
    
    static var background       = AdapterConfig.shared.backgroundColor
    
    static var container        = AdapterConfig.shared.containerColor
    
    
    static var theme            = AdapterConfig.shared.themeColor
    
    static var lightTheme       = AdapterConfig.shared.lightThemeColor
    
    static var highlightTheme   = AdapterConfig.shared.highlightThemeColor
    
    static var unable           = AdapterConfig.shared.unableColor
    
}
