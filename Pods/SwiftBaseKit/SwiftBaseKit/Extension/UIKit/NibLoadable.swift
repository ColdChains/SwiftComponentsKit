//
//  NibLoadable.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public protocol NibLoadable: NSObjectProtocol {
    
}

public extension NibLoadable where Self : UIView {
    
    static func nibView(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
}
