//
//  UIView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UIView {
    
    /// xib文件设置圆角
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}

public extension UIView {
    
    /// 视图所在的控制器
    var parentController : UIViewController? {
        var responder = self.next
        while let res = responder {
            if res.isKind(of: UIViewController.self) {
                return res as? UIViewController
            }
            responder = res.next
        }
        return nil
    }
    
    /// 视图所在的导航控制器
    var navigationController : UINavigationController? {
        var responder = self.next
        while let res = responder {
            if res.isKind(of: UINavigationController.self) {
                return res as? UINavigationController
            }
            responder = res.next
        }
        if parentController != nil {
            return parentController?.navigationController
        }
        return nil
    }
    
    /// 视图所在的标签控制器
    var tabBarController : UITabBarController? {
        var responder = self.next
        while let res = responder {
            if res.isKind(of: UITabBarController.self) {
                return res as? UITabBarController
            }
            responder = res.next
        }
        return nil
    }
}

public extension NSObject {
    
    /// 类名
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    /// 类名
    var className: String {
        get {
            let name =  type(of: self).description()
            if name.contains(".") {
                return name.components(separatedBy: ".")[1];
            } else {
                return name;
            }
        }
    }
    
}

public extension UIView {
    
    
    /// 旋转
    /// - Parameter angle: 旋转角度(0, 360)
    func rotationAnimation(with angle: CGFloat) {
        let degrees = angle * CGFloat(Double.pi) / 180
        transform = CGAffineTransform(rotationAngle: CGFloat(degrees))
    }
    
    /// 缩放
    /// - Parameter scale: 缩放比例
    func scaleAnimation(with scale: CGFloat) {
        transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    /// 添加阴影
    /// - Parameters:
    ///   - color: 颜色
    ///   - offset: 偏移量
    ///   - opacity: 透明度
    ///   - radius: 圆角
    func addShadow(_ color: UIColor, offset: CGSize = CGSize(), opacity: Float = 1, radius: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    /// 移除阴影
    func removeShadow() {
        layer.shadowOpacity = 0
    }
    
    /// 切顶部圆角
    /// - Parameter radius: 圆角
    /// - Returns: layer
    func clipsTopCornerRadius(_ radius: CGFloat) -> CAShapeLayer {
        return clipsCornerRadius(radius, positions: [.topLeft, .topRight])
    }
    
    /// 切底部圆角
    /// - Parameter radius: 圆角
    /// - Returns: layer
    func clipsBottomCornerRadius(_ radius: CGFloat) -> CAShapeLayer {
        return clipsCornerRadius(radius, positions: [.bottomLeft, .bottomRight])
    }
    
    /// 切左部圆角
    /// - Parameter radius: 圆角
    /// - Returns: layer
    func clipsLeftCornerRadius(_ radius: CGFloat) -> CAShapeLayer {
        return clipsCornerRadius(radius, positions: [.topLeft, .bottomLeft])
    }
    
    /// 切右部圆角
    /// - Parameter radius: 圆角
    /// - Returns: layer
    func clipsRightCornerRadius(_ radius: CGFloat) -> CAShapeLayer {
        return clipsCornerRadius(radius, positions: [.topRight, .bottomRight])
    }
    
    /// 切圆角
    /// - Parameter radius: 圆角
    /// - Returns: layer
    func clipsCornerRadius(_ radius: CGFloat, positions: UIRectCorner) -> CAShapeLayer {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: positions, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = false
        return maskLayer
    }
    
    /// 添加渐变色 自左向右
    /// - Parameter colors: 颜色
    /// - Returns: layer
    func addTransitionColorLeftToRight(_ colors: [UIColor]) -> CAGradientLayer {
        return addTransitionColor(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0), colors: colors)
    }
    
    /// 添加渐变色 自上向下
    /// - Parameter colors: 颜色
    /// - Returns: layer
    func addTransitionColorTopToBottom(_ colors: [UIColor]) -> CAGradientLayer {
        return addTransitionColor(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), colors: colors)
    }
    
    /// 添加渐变色
    /// - Parameters:
    ///   - startPoint: 起始点
    ///   - endPoint: 结束点
    ///   - colors: 颜色
    /// - Returns: layer
    func addTransitionColor(startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), colors: [UIColor]) -> CAGradientLayer {
        if colors.count == 0 {
            return CAGradientLayer()
        } else if colors.count == 1 {
            backgroundColor = colors[0]
            return CAGradientLayer()
        }
        let gradientLayer = CAGradientLayer()
        var colorArr: [CGColor] = []
        var locationArr: [NSNumber] = [0]
        for i in 0..<colors.count {
            colorArr.append(colors[i].cgColor)
            if i > 0 {
                locationArr.append(NSNumber(value: Float(i) / Float(colors.count - 1)))
            }
        }
        gradientLayer.colors = colorArr
        gradientLayer.locations = locationArr
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    /// 添加渐变色
    /// - Parameter colors: 颜色
    func drawLinearGradientLeftToRight(_ colors: [UIColor]) {
        drawLinearGradient(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0), colors: colors)
    }
    
    /// 添加渐变色
    /// - Parameter colors: 颜色
    func drawLinearGradientTopToBottom(_ colors: [UIColor]) {
        drawLinearGradient(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), colors: colors)
    }
    
    /// 添加渐变色
    /// - Parameter colors: 颜色
    func drawLinearGradient(startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), colors: [UIColor]) {
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        currentContext.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var colorComponents: [CGFloat] = []
        var locations: [CGFloat] = [0]
        for i in 0..<colors.count {
            if let components = colors[i].cgColor.components {
                for comp in components {
                    colorComponents.append(comp)
                }
            }
            if i > 0 {
                locations.append(CGFloat(i) / CGFloat(colors.count - 1))
            }
        }
        
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations, count: locations.count) else { return }
        let start = CGPoint(x: startPoint.x * frame.size.width, y: startPoint.y * frame.size.height)
        let end = CGPoint(x: endPoint.x * frame.size.width, y: endPoint.y * frame.size.height)
        currentContext.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        currentContext.restoreGState()
    }
    
    /// 添加虚线
    /// - Parameter color: 颜色
    /// - Returns: layer
    func addHorizontalDashLine(color: UIColor) -> CAShapeLayer {
        addDashLine(startPoint: CGPoint(), endPoint: CGPoint(x: frame.size.width, y: 0), lineWidth: 1, pattern: [8, 4], color: color)
    }
    
    /// 添加虚线
    /// - Parameter color: 颜色
    /// - Returns: layer
    func addPortraitDashLine(color: UIColor) -> CAShapeLayer {
        addDashLine(startPoint: CGPoint(), endPoint: CGPoint(x: 0, y: frame.size.height), lineWidth: 1, pattern: [8, 4], color: color)
    }
    
    /// 添加虚线
    /// - Parameter color: 颜色
    /// - Returns: layer
    func addBorderDashLine(width: CGFloat, color: UIColor) -> [CAShapeLayer] {
        var arr: [CAShapeLayer] = []
        let patten: Array<NSNumber> = [8, 4]
        arr.append(addDashLine(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: frame.size.height), lineWidth: frame.size.width, pattern: patten, color: color))
        arr.append(addDashLine(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: frame.size.width, y: 0), lineWidth: frame.size.width, pattern: patten, color: color))
        arr.append(addDashLine(startPoint: CGPoint(x: 0, y: frame.size.height), endPoint: CGPoint(x: frame.size.width, y: frame.size.height), lineWidth: frame.size.width, pattern: patten, color: color))
        arr.append(addDashLine(startPoint: CGPoint(x: frame.size.width, y: 0), endPoint: CGPoint(x: frame.size.width, y: frame.size.height), lineWidth: frame.size.width, pattern: patten, color: color))
        return arr
    }
    
    /// 添加虚线
    /// - Parameter color: 颜色
    /// - Returns: layer
    func addDashLine(startPoint: CGPoint, endPoint: CGPoint, lineWidth: CGFloat, pattern: [NSNumber], color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.fillColor = nil
        borderLayer.path = path.cgPath
        borderLayer.frame = bounds
        borderLayer.lineWidth = frame.size.width
        borderLayer.lineCap = .butt
        borderLayer.lineDashPattern = pattern
        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
}

public extension UIView {
    
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    var centerRect: CGRect {
        return CGRect(x: bounds.midX, y: bounds.midY, width: 0, height: 0)
    }
    
}
