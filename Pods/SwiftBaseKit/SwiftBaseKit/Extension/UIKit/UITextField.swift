//
//  UITextField.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UITextField {
    
    var cursorLocation: Int {
        guard let start = selectedTextRange?.start else { return 0 }
        return offset(from: beginningOfDocument, to: start)
    }
    
    var cursorLength: Int {
        guard let start = selectedTextRange?.start else { return 0 }
        guard let end = selectedTextRange?.end else { return 0 }
        return offset(from: start, to: end)
    }
    
    var cursorRange: NSRange {
        return NSRange(location: cursorLocation, length: cursorLength)
    }
    
    func getSelectedLocation() -> Int {
        return cursorLocation
    }
    
    func getSelectedRange() -> NSRange {
        return cursorRange
    }
    
    func setSelectedLocation(_ location: Int) {
        let startPosition = position(from: beginningOfDocument, offset: location)!
        let endPosition = position(from: beginningOfDocument, offset: location)!
        selectedTextRange = textRange(from: startPosition, to: endPosition)
    }
    
    func reSetSelectedLocation(_ begin: UITextPosition? = nil, offset: Int) {
        guard let startPosition = position(from: begin ?? beginningOfDocument, offset: offset) else { return }
        selectedTextRange = textRange(from: startPosition, to: startPosition)
    }
    
    func setSelectedRange(_ range: NSRange) {
        guard let startPosition = position(from: beginningOfDocument, offset: range.location), let endPosition = position(from: beginningOfDocument, offset: range.location + range.length) else { return }
        selectedTextRange = textRange(from: startPosition, to: endPosition)
    }
    
    func deleteSelectedString() {
        let location = cursorLocation > 0 ? cursorLocation - 1 : 0
        let length = cursorLength > 0 ? cursorLength : 1
        let str = text ?? ""
        text = str.trim(form: location, to: length)
        setSelectedLocation(location)
    }
    
}

public extension UITextField {
    
    enum Style {
        case telephone
        case bankcard
        case idcard
        var count: Int {
            switch self {
            case .telephone:
                return 11
            case .bankcard:
                return 19
            case .idcard:
                return 18
            }
        }
    }
    
    func isChanged(input string: String, style: Style) -> Bool {
        switch style {
        case .telephone:
            if !string.trimAllSapce.isNumber { return false }
            return telephoneIsChanged(input: string, style: style)
        case .bankcard:
            return bankcardIsChanged(input: string, style: style)
        case .idcard:
            return idcardIsChanged(input: string, style: style)
        }
    }
    
    private func telephoneIsChanged(input string: String, style: Style) -> Bool {
        let str = text ?? ""
        if string == "" {
            var location = cursorLocation > 0 ? cursorLocation - 1 : 0
            if str.substring(of: location) == " " {
                location -= 1
            }
            let length = cursorLength > 0 ? cursorLength : 1
            text = str.trim(form: location, to: length).formatTelephoneNumber
            setSelectedLocation(location)
        } else {
            if str.trimAllSapce.count >= style.count || !string.trimAllSapce.isNumber {
                return false
            }
            let head = str.substring(to: cursorLocation)
            let tail = str.substring(from: cursorLocation + cursorLength)
            let result = head + string + tail
            text = result.trimAllSapce.formatTelephoneNumber
            reSetSelectedLocation(offset: (head + string).trimAllSapce.formatTelephoneNumber.count)
        }
        return text != str
    }
    
    private func bankcardIsChanged(input string: String, style: Style) -> Bool {
        let str = text ?? ""
        if string == "" {
            var location = cursorLocation > 0 ? cursorLocation - 1 : 0
            if str.substring(of: location) == " " {
                location -= 1
            }
            let length = cursorLength > 0 ? cursorLength : 1
            text = str.trim(form: location, to: length).formatBankcardNumber
            setSelectedLocation(location)
        } else {
            if str.trimAllSapce.count >= style.count || !string.trimAllSapce.isNumber {
                return false
            }
            let head = str.substring(to: cursorLocation)
            let tail = str.substring(from: cursorLocation + cursorLength)
            let result = head + string + tail
            text = result.trimAllSapce.formatBankcardNumber
            reSetSelectedLocation(offset: (head + string).trimAllSapce.formatBankcardNumber.count)
        }
        return text != str
    }
    
    private func idcardIsChanged(input string: String, style: Style) -> Bool {
        let str = text ?? ""
        if string == "" {
            var location = cursorLocation > 0 ? cursorLocation - 1 : 0
            if str.substring(of: location) == " " {
                location -= 1
            }
            let length = cursorLength > 0 ? cursorLength : 1
            text = str.trim(form: location, to: length).formatIDcardNumber
            setSelectedLocation(location)
        } else {
            if str.trimAllSapce.count < style.count - 1 {
                if !string.trimAllSapce.isNumber {
                    return false
                }
            } else if str.trimAllSapce.count == style.count - 1 {
                if string != "x" && string != "X" && !string.isNumber {
                    return false
                }
            } else if str.trimAllSapce.count >= style.count {
                return false
            }
            let head = str.substring(to: cursorLocation)
            let tail = str.substring(from: cursorLocation + cursorLength)
            let result = head + string + tail
            text = result.trimAllSapce.formatIDcardNumber
            reSetSelectedLocation(offset: (head + string).trimAllSapce.formatIDcardNumber.count)
        }
        return text != str
    }
    
}
