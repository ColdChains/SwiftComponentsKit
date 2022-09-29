//
//  Bundle.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation

public extension Bundle {
    
    /// APP name
    var name: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    /// APP version
    var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    /// APP build
    var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    var desc: String {
        return [name, version, build].joined(separator: " ")
    }
    
}
