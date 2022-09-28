//
//  DarkGrayButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class DarkGrayButton: UIButton {
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setTitleColor(.darkGray, for: .normal)
        setTitleColor(.darkText, for: .highlighted)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(.darkGray, for: .normal)
        setTitleColor(.darkText, for: .highlighted)
   }

}
