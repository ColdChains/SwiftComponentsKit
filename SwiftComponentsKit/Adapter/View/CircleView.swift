//
//  CircleView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class CircleView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.width < frame.size.height ? frame.size.width / 2 : frame.size.height / 2
    }
    
}
