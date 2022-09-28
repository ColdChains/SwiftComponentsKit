//
//  CircleBackgroundView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class CircleBackgroundView: UIView {

    open override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .background
        layer.cornerRadius = frame.size.height / 2
    }
    
}
