//
//  AutoWidthConstraint.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class AutoWidthConstraint: NSLayoutConstraint {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        constant = constant * ScaleWidth
    }

}
