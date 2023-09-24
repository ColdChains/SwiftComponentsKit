//
//  CircleShadowView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class CircleShadowView: UIView {

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
        backgroundColor = .container
        layer.cornerRadius = frame.size.height / 2
        addShadow(.shadow)
    }

}
