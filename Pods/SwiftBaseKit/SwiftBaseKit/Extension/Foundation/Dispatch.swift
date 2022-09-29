//
//  DispatchQueue.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation

public extension DispatchQueue {
    
    /// 延迟执行
    /// - Parameters:
    ///   - timeInterval: 延迟时间
    ///   - handler: 执行内容
    func after(_ timeInterval: Double, handler:@escaping ()->()) {
        asyncAfter(deadline: .now() + timeInterval) {
            handler()
        }
    }
    
}

public extension DispatchSource {
    
    /// 定时器
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - repeats: 是否循环
    ///   - immediately: 是否立即执行
    ///   - handler: 执行内容
    /// - Returns: 定时器
    static func timer(_ timeInterval: Double, repeats: Bool, immediately: Bool = false, handler:@escaping (Double)->()) -> DispatchSourceTimer {
        var count = 0.0
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count += timeInterval
            if !immediately, count == timeInterval {
                return
            }
            DispatchQueue.main.async {
                handler(count)
            }
            if !repeats {
                timer.cancel()
            }
        }
        timer.resume()
        return timer
    }
    
    /// 定时器
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - repeats: 是否循环
    ///   - immediately: 是否立即执行
    ///   - handler: 执行内容
    /// - Returns: 定时器
    static func timer(_ timeInterval: Int, repeats: Bool, immediately: Bool = false, handler:@escaping (Int)->()) -> DispatchSourceTimer {
        var count = 0
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now(), repeating: Double(timeInterval))
        timer.setEventHandler {
            count += timeInterval
            if !immediately, count == timeInterval {
                return
            }
            DispatchQueue.main.async {
                handler(count)
            }
            if !repeats {
                timer.cancel()
            }
        }
        timer.resume()
        return timer
    }
    
    /// 定时器
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - total: 总时间
    ///   - handler: 执行内容
    ///   - finish: 结束回调
    /// - Returns: 定时器
    static func timer(_ timeInterval: Double, total: Double, handler:@escaping (Double)->(), finish:(()->())? = nil)  -> DispatchSourceTimer {
        var count = total + timeInterval
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count -= timeInterval
            if count <= 0 {
                count = 0
                timer.cancel()
                DispatchQueue.main.async {
                    finish?()
                }
            } else {
                DispatchQueue.main.async {
                    handler(count)
                }
            }
        }
        timer.resume()
        return timer
    }
    
    /// 定时器
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - total: 总时间
    ///   - handler: 执行内容
    ///   - finish: 结束回调
    /// - Returns: 定时器
    static func timer(_ timeInterval: Int, total: Int, handler:@escaping (Int)->(), finish:(()->())? = nil)  -> DispatchSourceTimer {
        var count = total + timeInterval
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(wallDeadline: .now(), repeating: Double(timeInterval))
        timer.setEventHandler {
            count -= timeInterval
            if count <= 0 {
                count = 0
                timer.cancel()
                DispatchQueue.main.async {
                    finish?()
                }
            } else {
                DispatchQueue.main.async {
                    handler(count)
                }
            }
        }
        timer.resume()
        return timer
    }
    
}
