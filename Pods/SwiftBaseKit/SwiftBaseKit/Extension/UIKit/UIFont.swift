//
//  UIFont.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UIFont {
    
    /// 常规字体
    static func regularFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    /// 中粗体
    static func mediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 粗体
    static func boldFont(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
}
