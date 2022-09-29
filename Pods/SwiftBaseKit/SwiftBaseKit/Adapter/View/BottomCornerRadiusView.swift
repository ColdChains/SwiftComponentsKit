//
//  BottomCornerRadiusView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class BottomCornerRadiusView: UIView {

    public override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        backgroundColor = .container
        addShadow(.shadow)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .container
        addShadow(.shadow)
    }
    
    open var shapeLayer: CAShapeLayer?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer?.removeFromSuperlayer()
        shapeLayer = clipsBottomCornerRadius(BaseConfig.shared.bigCornerRadius)
    }
    
}
