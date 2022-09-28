//
//  GlobalImageView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class GlobalImageView: UIImageView {

    open override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 2
        backgroundColor = .global
    }

}
