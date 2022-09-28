//
//  DarkTextButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class DarkTextButton: UIButton {
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setTitleColor(.darkText, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(.darkText, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
    }

}
