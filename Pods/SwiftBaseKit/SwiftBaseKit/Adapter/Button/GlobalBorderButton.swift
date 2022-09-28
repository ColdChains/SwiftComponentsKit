//
//  GlobalBorderButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class GlobalBorderButton: UIButton {

    override init(frame: CGRect = CGRect()) {
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
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.global.cgColor
        setTitleColor(.global, for: .normal)
        setTitleColor(.highlightGlobal, for: .highlighted)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.global.cgColor
    }

}
