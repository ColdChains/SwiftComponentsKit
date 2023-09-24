//
//  ContainerShadowView.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

open class ContainerShadowView: UIView {

    public override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        addShadow(.shadow)
        backgroundColor = .container
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        addShadow(.shadow)
        backgroundColor = .container
    }

}
