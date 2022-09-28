//
//  DarkTextLabel.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class DarkTextLabel: UILabel {
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        textColor = .darkText
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        textColor = .darkText
    }
    
}
