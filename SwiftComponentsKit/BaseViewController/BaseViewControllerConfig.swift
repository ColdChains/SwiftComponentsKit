//
//  BaseConfig.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation
import UIKit

public struct BaseViewControllerConfig {
    
    public static var shared = BaseViewControllerConfig()
    
    /// 是否打印日志 默认false release模式不起作用
    public var logEnabled = false
    
    
    /// 确认按钮文字
    public var confirmText = "确定"
    
    /// 取消按钮文字
    public var cancelText = "取消"
    
    
    /// 返回按钮图片
    public var backButtonImage: UIImage?

    /// 关闭按钮图片
    public var closeButtonImage: UIImage?
    
    
    /// 导航栏标题字体 默认16
    public var navigationTitleFont  = UIFont.boldSystemFont(ofSize: 16)

    /// 导航栏按钮字体 默认14
    public var navigationButtonFont = UIFont.systemFont(ofSize: 14)
    
    
    /// 标签栏颜色
    public var tabBarColor = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#000000")
    
    /// 标签栏选中颜色
    public var tabBarSelectedColor = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 导航栏颜色
    public var navigationBarColor = UIColor.dynamic(hex: "#FFFFFF", darkHex: "#000000")
    
    /// 导航栏标题颜色
    public var navigationTitleColor = UIColor.dynamic(hex: "#333333", darkHex: "#FFFFFF")
    
    /// 分割线颜色
    public var navigationDividerColor = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
    /// 进度条颜色
    public var progressColor = UIColor.blue
    
    /// 背景颜色
    public var backgroundColor = UIColor.dynamic(hex: "#F8F8F8", darkHex: "#000000")
    
}
