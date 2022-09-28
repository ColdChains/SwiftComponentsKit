//
//  DarkGrayBorderButton.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation
import UIKit

open class DarkGrayBorderButton: UIButton {

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
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(.darkGray, for: .normal)
        setTitleColor(.darkText, for: .highlighted)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.darkGray.cgColor
    }

}
