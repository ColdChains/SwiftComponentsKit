//
//  UnicodeToString.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension Array {
    
    /// 数组转字符串
    var toString: String {
        var str = "[\n"
        for item in self {
            var itemStr = ""
            if let str = item as? String {
                itemStr = str
            } else if let dict = item as? [String : Any], let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                itemStr = String(data: data, encoding: String.Encoding.utf8) ?? ""
            }
            str += itemStr + ",\n"
        }
        str += "]"
        return str.replacingOccurrences(of: ",\n]", with: "\n]")
    }
    
    var unicodeString: String {
        return self.description.unicodeString
    }
    
}

public extension Dictionary {
    
    /// 字典转字符串
    var toString: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let str = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        return str
    }
    
    /// 字符串转字典
    static func stringToDictionary(_ str: String) -> [String : Any] {
        guard let data = str.data(using: String.Encoding.utf8) else { return [:] }
        if let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return [:]
    }
    
    var unicodeString: String {
        return self.description.unicodeString
    }
    
}

public extension String {
    
    /// 字符串转字典
    var toDictionary: [String : Any] {
        guard let data = data(using: .utf8) else { return [:] }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return [:] }
        return dict
    }
    
    /// 字符串转数组
    var toArray: [[String : Any]] {
        guard let data = data(using: .utf8) else { return [] }
        guard let arr = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] else { return [] }
        return arr
    }
    
}

public extension String {
    
    /// unicode转中文
    var unicodeString: String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
            return returnStr.replacingOccurrences(of: "\\n", with: "\n")
        } catch {
            return self.replacingOccurrences(of: "\\", with: "")
        }
    }
    
}
