//
//  BottomMarginConstraint.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class BottomMarginConstraint: NSLayoutConstraint {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        constant = BottomMargin
    }

}
