//
//  NSDate.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

private var _defaultCalendar = Calendar.current

extension Calendar {
    public static func setDefaultCalendar(_ defaultCalendar: Calendar) {
        _defaultCalendar = defaultCalendar
    }

    public static func defaultCalendar() -> Calendar {
        return _defaultCalendar
    }
}

extension TimeZone {
    public static var UTC: TimeZone {
        return TimeZone(abbreviation: "UTC")!
    }
}

private var _defaultLocale = Locale.current

extension Locale {
    public static func setDefaultLocale(_ defaultLocale: Locale) {
        _defaultLocale = defaultLocale
    }

    public static func defaultLocale() -> Locale {
        return _defaultLocale
    }
}

extension DateComponents {
   
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, sec: Int = 0, nsec: Int = 0) {
        self.init()
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = sec
        self.nanosecond = nsec
        (self as NSDateComponents).calendar = Calendar.defaultCalendar()
        (self as NSDateComponents).timeZone = TimeZone.current
    }

    public init(hour: Int, minute: Int, sec: Int = 0, nsec: Int = 0) {
        self.init()
        self.year = 0
        self.month = 0
        self.day = 0
        self.hour = hour
        self.minute = minute
        self.second = sec
        self.nanosecond = nsec
        (self as NSDateComponents).calendar = Calendar.defaultCalendar()
        (self as NSDateComponents).timeZone = TimeZone.current
    }
}
