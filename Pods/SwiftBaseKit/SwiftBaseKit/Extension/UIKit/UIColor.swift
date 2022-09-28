//
//  UIColor.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

private func getRGBValue(hex: String) -> (CGFloat, CGFloat, CGFloat) {
    let str = hex.contains("#") ? hex.replacingOccurrences(of: "#", with: "") : hex
    let scanner = Scanner(string: str)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    return (CGFloat(r), CGFloat(g), CGFloat(b))
}

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }
    
    convenience init(netHex: Int) {
        self.init(
            red: (netHex >> 16) & 0xff,
            green: (netHex >> 8) & 0xff,
            blue: netHex & 0xff
        )
    }
    
    convenience init(hex: String) {
        let rgb = getRGBValue(hex: hex)
        self.init(
            red: rgb.0 / 0xff,
            green: rgb.1 / 0xff,
            blue: rgb.2 / 0xff, alpha: 1
        )
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        let rgb = getRGBValue(hex: hex)
        self.init(
            red: rgb.0 / 0xff,
            green: rgb.1 / 0xff,
            blue: rgb.2 / 0xff,
            alpha: alpha
        )
    }
    
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 0.7)
    }
    
    static func dynamic(hex: String, darkHex: String) -> UIColor {
        return UIColor.dynamic(hex: hex, darkHex: darkHex, alpha: 1)
    }
    
    static func dynamic(hex: String, darkHex: String, alpha: CGFloat) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor(hex: darkHex, alpha: alpha)
                }
                return UIColor(hex: hex, alpha: alpha)
            }
        } else {
            return UIColor(hex: hex, alpha: alpha)
        }
    }
    
}
