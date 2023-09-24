//
//  CircleThemeButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class CircleThemeButton: UIButton {
    
    public override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    private func initView() {
        layer.cornerRadius = frame.size.height / 2
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        initBackgroundColor()
        addObserver(self, forKeyPath: "enabled", options: .new, context: nil)
        addObserver(self, forKeyPath: "highlighted", options: .new, context: nil)
    }
    
    private func initBackgroundColor() {
        if isEnabled {
            if isHighlighted {
                backgroundColor = .highlightTheme
            } else {
                backgroundColor = .theme
            }
        } else {
            backgroundColor = .unable
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        initBackgroundColor()
    }
    
    deinit {
        removeObserver(self, forKeyPath: "enabled")
        removeObserver(self, forKeyPath: "highlighted")
    }
    
}
