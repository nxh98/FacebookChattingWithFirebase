//
//  NSBundle.swift
//  SwiftUtils
//
//  Created by DaoNV on 2/27/16.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public let kCFBundleDisplayNameKey = "CFBundleDisplayName"
public let kCFBundleNameKey = "CFBundleName"
public let kCFBundleShortVersionKey = "CFBundleShortVersionString"

extension Bundle {
    public var name: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleDisplayNameKey] as? String ?? info[kCFBundleNameKey] as? String ?? ""
    }

    public var version: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleShortVersionKey] as? String ?? ""
    }

    public var build: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleVersionKey as String] as? String ?? ""
    }
}
