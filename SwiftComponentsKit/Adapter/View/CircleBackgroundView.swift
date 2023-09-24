//
//  CircleBackgroundView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class CircleBackgroundView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .background
        layer.cornerRadius = frame.size.height / 2
    }
    
}
