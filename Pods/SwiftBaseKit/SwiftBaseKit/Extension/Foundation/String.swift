//
//  String.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension String {
    
    func index(of index: Int) -> Index {
        var offset = index > count ? count : index
        offset = offset < 0 ? 0 : offset
        return self.index(startIndex, offsetBy: offset)
    }
    
    func substring(of location: Int) -> String {
        if self == "" { return "" }
        let start = index(of: location)
        return String(self[start...start])
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(of: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(of: to)
        return String(self[..<toIndex])
    }
    
    func substring(from: Int, to: Int) -> String {
        let startIndex = index(of: from)
        let endIndex = index(of: to)
        return String(self[startIndex..<endIndex])
    }
    
    func substring(contains: String) -> String {
        if self.contains(contains) {
            let end = index(of: self.count - contains.count )
            return String(self[..<end])
        }
        return ""
    }
    
}

public extension String {
    
    var trim: String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    var trimAllSapce: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    var trimWithEnter: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimLine: String {
        return replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
    }
    
    var trimLast: String {
        if self == "" {
            return ""
        }
        return substring(to: count - 1)
    }
    
    func trim(at index: Int) -> String {
        return substring(to: index) + substring(from: index + 1)
    }
    
    func trim(form start: Int, to end: Int) -> String {
        return substring(to: start) + substring(from: start + end)
    }
    
}

public extension String {
    
    var formatTelephoneNumber: String {
        let str = trimAllSapce
        let num = str.count > 11 ? 11 : str.count
        var result = ""
        for i in 0..<num {
            result += str.substring(of: i)
            if i == 2 || i == 6 {
                result += " "
            }
        }
        return result
    }
    
    var formatBankcardNumber: String {
        let str = trimAllSapce
        let num = str.count > 19 ? 19 : str.count
        var result = ""
        for i in 0..<num {
            result += str.substring(of: i)
            if i % 4 == 3 {
                result += " "
            }
        }
        return result
    }
    
    var formatIDcardNumber: String {
        let str = trimAllSapce
        let num = str.count > 18 ? 18 : str.count
        var result = ""
        for i in 0..<num {
            result += str.substring(of: i)
            if i == 5 || i == 9 || i == 13 {
                result += " "
            }
        }
        return result
    }
    
}

public extension String {
    
    var isTelephoneNumber: Bool {
        //let regex = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$"
        let regex = "^1[3-9]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isIdentifyNumber: Bool {
        let regex = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isAlphabet: Bool {
        let regex = "^[a-z|A-Z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isAlphabetAndNumber: Bool {
        let regex = "^[0-9|a-z|A-Z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isNumber: Bool {
        let regex = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isIntNumber: Bool {
        let regex = "^0|[1-9][0-9]*|-[1-9][0-9]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isDoubleNumber: Bool {
        let arr = components(separatedBy: ".")
        if arr.count == 1 {
            return arr[0].isIntNumber
        } else if arr.count == 2 {
            return arr[0].isIntNumber && arr[1].isNumber
        } else {
            return false
        }
    }
    
    var isFormatDoubleNumber: Bool {
        let arr = components(separatedBy: ".")
        if arr.count == 1 {
            return arr[0].isIntNumber
        } else if arr.count == 2 {
            return arr[0].isIntNumber && arr[1].isNumber && arr[1].count <= 2
        } else {
            return false
        }
    }
    
}

public extension String {
    
    func boundingRect(with width: CGFloat, font: UIFont?, lineSpace: CGFloat = -1) -> CGRect {
        let fon = font ?? UIFont.systemFont(ofSize: 16)
        let size = CGSize(width: width, height: 10000)
        var attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : fon]
        if lineSpace > 0 {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            attributes[NSAttributedString.Key.paragraphStyle] = style
        }
        let rect = (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect
    }
    
    func boundingRectWidth(with width: CGFloat, font: UIFont?) -> CGFloat {
        let rect = boundingRect(with: width, font: font)
        return ceil(rect.size.width)
    }
    
    func boundingRectHeight(with width: CGFloat, font: UIFont?) -> CGFloat {
        let rect = boundingRect(with: width, font: font)
        return ceil(rect.size.height)
    }
    
    func numberOfLines(with Width: CGFloat, font: UIFont?) -> CGFloat {
        let size = font?.pointSize ?? 16
        let height = boundingRectHeight(with: Width, font: font)
        return ceil(height / size)
    }
    
}

public extension String {
    
    var attributedString: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        return attributedString
    }
    
    func attributedString(lineSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: count))
        return attributedString
    }
    
    func attributedString(with subString: String?, font: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = self.range(with: subString)
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let fon = font {
            attributes[NSAttributedString.Key.font] = fon
        }
        if let col = color {
             attributes[NSAttributedString.Key.foregroundColor] = col
        }
        attributedString.addAttributes(attributes, range: range)
        return attributedString
    }
    
    func attributedString(with subStrings: [String]?, font: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        guard let arr = subStrings else { return attributedString }
        for subString in arr {
            let range = self.range(with: subString)
            var attributes: [NSAttributedString.Key : Any] = [:]
            if let fon = font {
                attributes[NSAttributedString.Key.font] = fon
            }
            if let col = color {
                attributes[NSAttributedString.Key.foregroundColor] = col
            }
            attributedString.addAttributes(attributes, range: range)
        }
        return attributedString
    }
    
    func range(with subString: String?) -> NSRange {
        guard let str = subString else {
            return NSRange()
        }
        return (self as NSString).localizedStandardRange(of: str)
    }
    
}

public extension String {
    
    func timeSymbolString() -> String {
        let time = intValue
        if time > 3600 {
            return String(format: "%02d:%02d:%02d", time / 3600, (time % 3600) / 60, time % 60)
        }
        return String(format: "%02d:%02d", time / 60, time % 60)
    }
    
    func timeSymbolStringNoSecond() -> String {
        let time = intValue / 60
        return String(format: "%02d:%02d", time / 60, time % 60)
    }
    
    func timeString() -> String {
        let time = intValue
        if time >= 24 * 60 * 60 {
            if time %  (24 * 60 * 60) == 0 {
                return String(format: "%ld天", time / (24 * 60 * 60))
            } else {
                return String(format: "%ld天%ld小时", time / (24 * 60 * 60), (time % (24 * 60 * 60)) / (60 * 60))
            }
        } else if time >= (60 * 60) {
            if time %  (60 * 60) == 0 {
                return String(format: "%ld小时", time / (60 * 60))
            } else {
                return String(format: "%ld小时%ld分", time / (60 * 60), (time % (60 * 60)) / 60)
            }
        } else if time >= 60 {
            return String(format: "%ld分钟", time / 60)
        } else if time > 0 {
            return String(format: "1分钟")
        } else {
            return String(format: "0分钟")
        }
    }
    
    var moneyString: String {
        return doubleFormatString() + "元"
    }
    
}
