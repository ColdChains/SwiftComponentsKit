//
//  Constant.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/22.
//

import Foundation
import UIKit

/// 屏幕大小
public let ScreenBounds                = UIScreen.main.bounds
/// 屏幕实际的宽
public let RealWidth                   = UIScreen.main.bounds.size.width
/// 屏幕实际的高
public let RealHeight                  = UIScreen.main.bounds.size.height
/// 屏幕的短边
public let ScreenWidth                 = RealWidth < RealHeight ? RealWidth : RealHeight
/// 屏幕的长边
public let ScreenHeight                = RealWidth < RealHeight ? RealHeight : RealWidth
/// 宽度适配比例
public let ScaleWidth                  = ScreenWidth / 375.0
/// 高度适配比例
public let ScaleHeight                 = ScreenHeight / 667.0
/// 缩放比
public let ScaleSize                   = ScaleWidth > 1 ? ScaleWidth : 1
/// 状态栏高度
public let StatusBarHeight             = UIApplication.shared.statusBarFrame.size.height >= 44 ? UIApplication.shared.statusBarFrame.size.height : 20
/// 导航栏高度
public let NavigationBarHeight         = StatusBarHeight + 44
/// 标签栏高度
public let TabBarHeight: CGFloat       = StatusBarHeight > 20 ? 83 : 49
/// Home条高度
public let HomeBarHeight: CGFloat      = StatusBarHeight > 20 ? 34 : 0
/// 底部间距
public let BottomMargin: CGFloat       = StatusBarHeight > 20 ? 44 : BaseConfig.shared.margin

public let ISiPhoneX                   = StatusBarHeight > 20 ? true : false

public let ISiPhoneSE                  = ScreenWidth < 375 ? true : false
