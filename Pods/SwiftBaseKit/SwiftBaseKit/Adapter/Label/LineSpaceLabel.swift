//
//  LineSpaceLabel.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class LineSpaceLabel: UILabel {
    
    var lineSpace: CGFloat = 4 {
        didSet {
            attributedText = text?.attributedString(lineSpace: lineSpace, alignment: textAlignment)
        }
    }
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        lineSpace = 4
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        lineSpace = 4
        addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        attributedText = text?.attributedString(lineSpace: lineSpace, alignment: textAlignment)
    }

}
