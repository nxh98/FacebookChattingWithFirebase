//
//  Double.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Double {
    public var abs: Double {
        return Foundation.fabs(self)
    }

    public var sqrt: Double {
        return Foundation.sqrt(self)
    }

    public var floor: Double {
        return Foundation.floor(self)
    }

    public var ceil: Double {
        return Foundation.ceil(self)
    }

    public var round: Double {
        return Foundation.round(self)
    }

    public func clamp(_ min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }

    public static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }

    public func distance(_ precision: Int = -1, meter: String = "m", kilometer: String = "km") -> String { // precision < 0: Auto
        var num = self
        var unit = meter
        if num > 1000.0 {
            unit = kilometer
            num /= 1000.0
        }
        if precision == -1 {
            if num == trunc(num) {
                return String(format: "%.0f%@", num, unit)
            } else {
                return String(format: "%.1f%@", num, unit)
            }
        } else {
            let format = "%.\(precision)f%@"
            return String(format: format, num, unit)
        }
    }
}
