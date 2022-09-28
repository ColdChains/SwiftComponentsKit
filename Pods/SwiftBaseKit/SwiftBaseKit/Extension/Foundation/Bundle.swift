//
//  Bundle.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation

public extension Bundle {
    
    var name: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
}
