//
//  StringExt.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

enum Process {
    case encode
    case decode
}

extension String {

    var isNotEmpty: Bool {
        return !isEmpty
    }

    func base64(_ method: Process) -> String? {
        switch method {
        case .encode:
            guard let data = data(using: .utf8) else { return nil }
            return data.base64EncodedString()
        case .decode:
            guard let data = Data(base64Encoded: self) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    }

    struct AttributeData {
        var textRange: String
        var attributes: [NSAttributedString.Key: AnyObject]?
        var attributeItems: [(NSAttributedString.Key, Any)]
    }

    func customAttributedString(data: [AttributeData]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for attrData in data {
            let rangerString = (self as NSString).range(of: attrData.textRange)
            for item in attrData.attributeItems {
                attributedString.addAttribute(item.0, value: item.1, range: rangerString)
            }
            if let attributes = attrData.attributes {
                attributedString.addAttributes(attributes, range: rangerString)
            }
        }
        return attributedString
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }

    public var length: Int {
        return count
    }

    func contentHeight(contentWidth: CGFloat, attributedString: NSAttributedString) -> CGFloat {
        let constraintRect = CGSize(width: contentWidth, height: .greatestFiniteMagnitude)
        let boundingBox = attributedString.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return boundingBox.height
    }

    func contentHeight(contentWidth: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        let constraintRect = CGSize(width: contentWidth, height: .greatestFiniteMagnitude)
        let boundingBox = attributedString.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return boundingBox.height
    }

    private var isAlphanumeric: Bool {
        return range(of: "[0-9]", options: .regularExpression) != nil
    }

    func jsonDecode() -> String {
        guard let decoded: String? = try? JSONSerialization.jsonObject(with: Data("\"\(self)\"".utf8), options: .allowFragments) as? String,
            let data: Data = decoded?.data(using: .unicode),
            let str: String = String(data: data, encoding: .unicode) else { return self }
        return str
    }

    func decode() -> String {
       let s = self.jsonDecode()
       return s.unescapedData()
    }

    func unescapedData() -> String {
        guard let data = self.unescaped.data(using: .utf8), !self.isEmpty,
            let string = String(data: data, encoding: .nonLossyASCII) else {
                return self.unescaped
        }
        return string
    }

    var unescaped: String {
        let entities: [String] = ["\0", "\t", "\n", "\r", "\"", "\'"]
        var current = self
        for entity in entities {
            let descriptionCharacters = entity.debugDescription.dropFirst().dropLast()
            let description: String = String(descriptionCharacters)
            current = current.replacingOccurrences(of: description, with: entity)
        }
        return current
    }

    func encode() -> String {
        guard let data = self.data(using: .nonLossyASCII, allowLossyConversion: true), let string = String(data: data, encoding: .utf8) else { return self }
        return string
    }

    // MARK: - Bad words list
    static let badWordsList: [String] = {
        if let filepath = Bundle.main.path(forResource: "BadWords", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                var badWordsList = contents.components(separatedBy: "\\|")
                return badWordsList.removeAll("\n")
            } catch {
                return []
            }
        } else {
            return []
        }
    }()

    /// Initializes an NSURL object with a provided URL string. (read-only)
    public var url: URL? {
        return URL(string: self)
    }

    /// The host, conforming to RFC 1808. (read-only)
    public var host: String {
        if let url = url, let host = url.host {
            return host
        }
        return ""
    }

    /// Replacing `-` to `/`
    var replacingFormatDate: String {
        return replacingOccurrences(of: "-", with: "/")
    }

    func setAttributed(for string: [String],
                       color: UIColor,
                       lineSpacing: CGFloat? = nil,
                       backgroundColor: UIColor? = nil,
                       alignment: NSTextAlignment? = nil,
                       font: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString? {
        let attributed = NSMutableAttributedString(string: self)
        for item in string {
            let range = (self as NSString).range(of: item)
            attributed.addAttribute(.foregroundColor, value: color, range: range)
            if let font = font {
                attributed.addAttributes(font, range: range)
            }
            if let backgroundColor = backgroundColor {
                attributed.addAttribute(.backgroundColor, value: backgroundColor, range: range)
            }
        }

        let stringStyle = NSMutableParagraphStyle()
        if let alignment = alignment {
            stringStyle.alignment = alignment
        }
        if let spacing = lineSpacing {
            stringStyle.lineSpacing = spacing
            attributed.addAttribute(.paragraphStyle, value: stringStyle, range: NSRange(location: 0, length: self.count))
        }
        return attributed
    }

    var interger: Int {
        if let number = self.int {
            return number
        } else {
            return 0
        }
    }

    // set attributed strings with color
    func attributedStringWithColor(_ highlightTexts: [(String, Int)],
                                   color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), alignment: NSTextAlignment = .left,
                                   lineSpacing: CGFloat? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for (string, index) in highlightTexts {
            var range: NSRange?
            if index == 1 {
                range = (self as NSString).range(of: string)
            } else {
                var startRange = NSRange(location: 0, length: self.count)
                for _ in 1...index {
                    range = (self as NSString).range(of: string, range: startRange)
                    if let range = range {
                        startRange = NSRange(location: range.location + range.length,
                                             length: self.count - range.location - range.length)
                    }
                }
            }
            if let range = range {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = alignment
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        }
        return attributedString
    }

    func makeHighLight(highLight: String..., highLightColor: UIColor, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: self, attributes: attributes)
        for item in highLight {
            let range = (self as NSString).range(of: item)
            attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: highLightColor, range: range)
        }
        return attributed
    }
}

// MARK: - Unwrap string
extension Optional where Wrapped == String {

    var content: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return ""
        }
    }
}

extension NSMutableAttributedString {
    public func append(string: String, attributes: [NSAttributedString.Key: Any]) {
        let str = NSMutableAttributedString(string: string, attributes: attributes)
        append(str)
    }
}

extension String {
    func setFontColor(for string: String, lineSpacing: CGFloat? = nil, attrs: [NSAttributedString.Key: Any]) -> NSAttributedString? {
        let attributed = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: string)
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributed.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: count))
        }
        attributed.addAttributes(attrs, range: range)
        return attributed.copy() as? NSAttributedString
    }

    var imageSize: CGSize? {
        guard let url = self.url,
            let dict = url.queryParameters,
            let width = dict["w"]?.cgFloat(),
            let height = dict["h"]?.cgFloat()
            else { return nil }
        return CGSize(width: width, height: height)
    }
}

extension NSRegularExpression {
    class func regex(pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
        let options: NSRegularExpression.Options = ignoreCase ? [.caseInsensitive]: []
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: options)
        } catch {
            regex = nil
        }
        return regex
    }
}

extension String {
    func replace(pattern: String, withString replacementString: String, ignoreCase: Bool = false) -> String? {
        if let regex = NSRegularExpression.regex(pattern: pattern, ignoreCase: ignoreCase) {
            let range = NSRange(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacementString)
        }
        return nil
    }

    func replace(fromIndex index: Int, withString replacementString: String) -> String? {
        var temp = self
        let subString = temp.suffix((self.count - 1) - index)
        if let range = temp.range(of: subString) {
            temp.replaceSubrange(range, with: replacementString)
            return temp
        } else {
            return nil
        }
    }

    func replaceName(maxLength length: Int, withString replacementString: String) -> String {
        if self.count > length {
            return self.prefix(length) + replacementString
        } else {
            return self
        }
    }
}
