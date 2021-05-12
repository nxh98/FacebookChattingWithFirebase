//
//  Type.swift
//  SwiftUtils
//
//  Created by DaoNV on 12/30/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

typealias JSObject = [String: AnyObject]
typealias JSArray = [JSObject]

public enum DeviceType {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPhoneX
    case iPhoneXS
    case iPhoneXR
    case iPhoneXSMax
    case iPad
    case iPadPro105
    case iPadPro129

    public var size: CGSize {
        switch self {
        case .iPhone4: return CGSize(width: 320, height: 480)
        case .iPhone5: return CGSize(width: 320, height: 568)
        case .iPhone6: return CGSize(width: 375, height: 667)
        case .iPhone6p: return CGSize(width: 414, height: 736)
        case .iPhoneX: return CGSize(width: 375, height: 812)
        case .iPhoneXS: return CGSize(width: 375, height: 812)
        case .iPhoneXR: return CGSize(width: 414, height: 896)
        case .iPhoneXSMax: return CGSize(width: 414, height: 896)
        case .iPad: return CGSize(width: 768, height: 1024)
        case .iPadPro105: return CGSize(width: 834, height: 1112)
        case .iPadPro129: return CGSize(width: 1024, height: 1366)
        }
    }
}

public let kScreenSize = UIScreen.main.bounds.size

public let iPhone = (UIDevice.current.userInterfaceIdiom == .phone)
public let iPad = (UIDevice.current.userInterfaceIdiom == .pad)

public let iPhone4 = (iPhone && DeviceType.iPhone4.size == kScreenSize)
public let iPhone5 = (iPhone && DeviceType.iPhone5.size == kScreenSize)
public let iPhone6 = (iPhone && DeviceType.iPhone6.size == kScreenSize)
public let iPhone6p = (iPhone && DeviceType.iPhone6p.size == kScreenSize)
public let iPhoneX = (iPhone && DeviceType.iPhoneX.size == kScreenSize)
public let iPhoneXS = (iPhone && DeviceType.iPhoneXS.size == kScreenSize)
public let iPhoneXR = (iPhone && DeviceType.iPhoneXR.size == kScreenSize)
public let iPhoneXSMax = (iPhone && DeviceType.iPhoneXSMax.size == kScreenSize)
