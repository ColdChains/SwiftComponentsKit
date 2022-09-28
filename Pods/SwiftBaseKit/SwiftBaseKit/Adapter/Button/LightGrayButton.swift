//
//  LightGrayButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class LightGrayButton: UIButton {
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setTitleColor(.lightGray, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func awakeFromNib() {
         super.awakeFromNib()
         setTitleColor(.lightGray, for: .normal)
         setTitleColor(.darkGray, for: .highlighted)
    }

}
