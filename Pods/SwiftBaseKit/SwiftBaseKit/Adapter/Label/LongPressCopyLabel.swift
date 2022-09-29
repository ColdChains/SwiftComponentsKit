//
//  LongPressCopyLabel.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class LongPressCopyLabel: UILabel {
    
    open var copyClosure: ((String?) -> Void)?
    
    public override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        addLongPressCopyGestureRecognizer()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        addLongPressCopyGestureRecognizer()
    }
    
}

public extension UILabel {
    
    /// 添加长按复制手势
    func addLongPressCopyGestureRecognizer() {
        for ges in gestureRecognizers ?? [] {
            if ges.isKind(of: UILongPressGestureRecognizer.self) {
                return
            }
        }
        isUserInteractionEnabled = true
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(longRecognizerAction))
        tap.minimumPressDuration = 0.5
        addGestureRecognizer(tap)
    }
    
    @objc private func longRecognizerAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .began {
            return
        }
        UIPasteboard.general.string = text
        if let label = self as? LongPressCopyLabel {
            label.copyClosure?(text)
        }
    }
    
}
