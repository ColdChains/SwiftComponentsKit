//
//  Double.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public func floorInt(_ value: Double) -> Int {
    return Int(floor(value))
}

public func floorInt(_ value: Float) -> Int {
    return Int(floor(value))
}

public func floorInt(_ value: CGFloat) -> Int {
    return Int(floor(value))
}

public func ceilInt(_ value: Double) -> Int {
    return Int(ceil(value))
}

public func ceilInt(_ value: Float) -> Int {
    return Int(ceil(value))
}

public func ceilInt(_ value: CGFloat) -> Int {
    return Int(ceil(value))
}

public extension Int {
    
    var toString: String {
        return "\(self)"
    }
    
}

public extension Bool {
    
    var toInt: Int {
        return self ? 1 : 0
    }
    
    var toString: String {
        return self ? "1" : "0"
    }
    
}

public extension Float {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toString: String {
        var str = String(format: "%f", self)
        while str.hasSuffix("0") {
            str = str.substring(to: str.count - 1)
        }
        if str.hasSuffix(".") {
            str = str.substring(to: str.count - 1)
        }
        return str
    }
    
    var formatString: String {
        return String(format: "%.2f", self)
    }
    
}

public extension CGFloat {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toString: String {
        var str = String(format: "%f", self)
        while str.hasSuffix("0") {
            str = str.substring(to: str.count - 1)
        }
        if str.hasSuffix(".") {
            str = str.substring(to: str.count - 1)
        }
        return str
    }
    
    var formatString: String {
        return String(format: "%.2f", self)
    }
    
    func formatString(bit: Int) -> String {
        let str = "%.\(bit)f"
        return String(format: str, self)
    }
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}

public extension Double {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toString: String {
        var str = String(format: "%f", self)
        while str.hasSuffix("0") {
            str = str.substring(to: str.count - 1)
        }
        if str.hasSuffix(".") {
            str = str.substring(to: str.count - 1)
        }
        return str
    }
    
    var formatString: String {
        return String(format: "%.2f", self)
    }
    
    func formatString(bit: Int) -> String {
        let str = "%.\(bit)f"
        return String(format: str, self)
    }
    
}

public extension String {
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    var integerValue: NSInteger {
        return NSInteger((self as NSString).integerValue)
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var cgfloatValue: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var ceilValue: Int {
        return "\(ceil(cgfloatValue))".integerValue
    }
    
    var roundValue: Int {
        return "\(round(cgfloatValue))".integerValue
    }
    
    var floorValue: Int {
        return "\(floor(cgfloatValue))".integerValue
    }
    
}

public extension String {
    
    var intString: String {
        return String(format: "%d", intValue)
    }
    
    var floatString: String {
        var str = String(format: "%f", floatValue)
        while str.hasSuffix("0") {
            str = str.substring(to: str.count - 1)
        }
        if str.hasSuffix(".") {
            str = str.substring(to: str.count - 1)
        }
        return str
    }
    
    func floatFormatString(bit: Int = 2) -> String {
        return String(format: "%.\(bit)f", floatValue)
    }
    
    var doubleString: String {
        var str = String(format: "%f", doubleValue)
        while str.hasSuffix("0") {
            str = str.substring(to: str.count - 1)
        }
        if str.hasSuffix(".") {
            str = str.substring(to: str.count - 1)
        }
        return str
    }
    
    func doubleFormatString(bit: Int = 2) -> String {
        return String(format: "%.\(bit)f", doubleValue)
    }
    
}
