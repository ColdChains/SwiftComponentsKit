//
//  HomeBarHeightConstraint.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class HomeBarHeightConstraint: NSLayoutConstraint {

    open override func awakeFromNib() {
        super.awakeFromNib()
        constant = HomeBarHeight
    }
    
}
