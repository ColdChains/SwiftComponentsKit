//
//  DateComponents.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation

public extension DateComponents {
    
    var seconds: Int {
        var sec = 0
        if let n = second {
            sec += n
        }
        if let n = minute {
            sec += n * 60
        }
        if let n = hour {
            sec += n * 60 * 60
        }
        if let n = day {
            sec += n * 60 * 60 * 24
        }
        return sec
    }
    
}
