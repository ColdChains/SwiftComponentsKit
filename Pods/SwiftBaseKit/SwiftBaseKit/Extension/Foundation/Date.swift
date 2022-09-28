//
//  Date.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import Foundation

public extension Date {
    
    var year: Int {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self).intValue
    }
    
    var month: Int {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "MM"
        return formatter.string(from: self).intValue
    }
    
    var day: Int {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "dd"
        return formatter.string(from: self).intValue
    }
    
    var todayZeroDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,.month,.day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        guard let d = calendar.date(from: components) else {
            return self
        }
        return d
    }
    
    var previousDay: Date {
        var interval = timeIntervalSince1970;
        interval -= 24 * 60 * 60;
        return Date(timeIntervalSince1970: interval)
    }
    
    var nextDay: Date {
        var interval = timeIntervalSince1970;
        interval += 24 * 60 * 60;
        return Date(timeIntervalSince1970: interval)
    }
    
    func toString(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

public extension String {
    
    //从date到self的时间差
    func getTimeDifference(form date: Date) -> DateComponents {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let endDate = formatter.date(from: self) else { return DateComponents() }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: endDate)
        return components;
    }
    
    //从self到date的时间差
    func getTimeDifference(to date: Date) -> DateComponents {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let startDate = formatter.date(from: self) else { return DateComponents() }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: date)
        return components;
    }
    
    //从startDate到endDate的时间差
    func getTimeDifference(form startDate: Date, to endDate: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: endDate)
        return components;
    }
    
    //字符串转日期
    func toDate(with format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func dateStringWithDot() -> String? {
        return toDate()?.toString("yyyy.MM.dd HH:mm:ss")
    }
    
    func dateStringWithDotNoSecond() -> String? {
        return toDate()?.toString("yyyy.MM.dd HH:mm")
    }
    
    func dateStringWithDotNoTime() -> String? {
        return toDate()?.toString("yyyy.MM.dd")
    }
    
    func dateStringNoSecond() -> String? {
        return toDate()?.toString("yyyy-MM-dd HH:mm")
    }
    
    func dateStringNoYearAndSecond() -> String? {
        return toDate()?.toString("MM-dd HH:mm")
    }
    
    func dateStringNoTime() -> String? {
        return toDate()?.toString("yyyy-MM-dd")
    }
    
    func dateStringWithChinese() -> String? {
        return toDate()?.toString("MM月dd日 HH:mm")
    }
    
    func dateStringWithChineseNoTime() -> String? {
        return toDate()?.toString("yyyy年MM月dd日")
    }
    
    func dateString(format: String) -> String? {
        return toDate()?.toString(format)
    }
    
    func timeIntervalToDateString() -> String? {
        return Date(timeIntervalSince1970: TimeInterval(intValue) / 1000).toString()
    }
    
    func timeIntervalToDateStringNoSecond() -> String? {
        return Date(timeIntervalSince1970: TimeInterval(intValue) / 1000).toString("yyyy-MM-dd HH:mm")
    }
    
    func timeIntervalToDateStringNoTime() -> String? {
        return Date(timeIntervalSince1970: TimeInterval(intValue) / 1000).toString("yyyy-MM-dd")
    }
    
}
