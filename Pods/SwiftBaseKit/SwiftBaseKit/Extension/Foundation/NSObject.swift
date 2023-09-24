//
//  NSObject.swift
//  SwiftBaseKit
//
//  Created by lax on 2023/9/22.
//

import Foundation

extension NSObject {

    public func printLog(_ any: Any? = nil) {
#if DEBUG
        print("\(self) \(any ?? "")")
#endif
    }

}
