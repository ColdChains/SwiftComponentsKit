//
//  ThemeButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class ThemeButton: UIButton {
    
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
        if isEnabled {
            setTitleColor(.theme, for: .normal)
            setTitleColor(.highlightTheme, for: .highlighted)
        } else {
            setTitleColor(.lightGray, for: .normal)
            setTitleColor(.darkGray, for: .highlighted)
        }
        addObserver(self, forKeyPath: "enabled", options: .new, context: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath, path == "enabled" {
            if isEnabled {
                setTitleColor(.theme, for: .normal)
                setTitleColor(.highlightTheme, for: .highlighted)
            } else {
                setTitleColor(.lightGray, for: .normal)
                setTitleColor(.darkGray, for: .highlighted)
            }
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "enabled")
    }
    
}
