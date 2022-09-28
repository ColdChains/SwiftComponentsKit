//
//  AutoHeightConstraint.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class AutoHeightConstraint: NSLayoutConstraint {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        constant = constant * ScaleHeight
    }

}
