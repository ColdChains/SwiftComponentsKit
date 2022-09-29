//
//  LineSpaceLabel.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class LineSpaceLabel: UILabel {
    
    open var lineSpace: CGFloat = 4 {
        didSet {
            attributedText = text?.attributedString(lineSpace: lineSpace, alignment: textAlignment)
        }
    }
    
    public override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        lineSpace = BaseConfig.shared.lineSpace
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        lineSpace = BaseConfig.shared.lineSpace
        addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        attributedText = text?.attributedString(lineSpace: lineSpace, alignment: textAlignment)
    }

}
