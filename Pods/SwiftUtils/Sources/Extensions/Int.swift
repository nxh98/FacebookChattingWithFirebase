//
//  Int.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension Int {
    public func loop(_ block: () -> Void) {
        for _ in 0 ..< self {
            block()
        }
    }

    public var isEven: Bool {
        return (self % 2) == 0
    }

    public var isOdd: Bool {
        return (self % 2) == 1
    }

    public func clamp(_ range: Range<Int>) -> Int {
        return clamp(range.lowerBound, range.upperBound - 1)
    }

    public func clamp(_ min: Int, _ max: Int) -> Int {
        return Swift.max(min, Swift.min(max, self))
    }

    public var digits: [Int] {
        var result = [Int]()
        for char in String(self) {
            let string = String(char)
            if let toInt = Int(string) {
                result.append(toInt)
            }
        }
        return result
    }

    public var abs: Int {
        return Swift.abs(self)
    }

    public func gcd(_ num: Int) -> Int {
        return num == 0 ? self : num.gcd(self % num)
    }

    public func lcm(_ num: Int) -> Int {
        return (self * num).abs / gcd(num)
    }

    public var factorial: Int {
        return self == 0 ? 1 : self * (self - 1).factorial
    }

    public var ordinal: String {
        let suffix: [String] = ["th", "st", "nd", "rd", "th"]
        var index = 0
        if self < 11 || self > 13 {
            index = Swift.min(suffix.count - 1, self % 10)
        }
        return String(format: "%zd%@", self, suffix[index])
    }

    public static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
