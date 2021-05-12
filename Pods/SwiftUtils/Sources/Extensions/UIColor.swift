//
//  UIColor.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIColor {
    public class func RGB(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) -> UIColor {
        let red = max(0.0, min(CGFloat(red) / 255.0, 1.0))
        let green = max(0.0, min(CGFloat(green) / 255.0, 1.0))
        let blue = max(0.0, min(CGFloat(blue) / 255.0, 1.0))
        let alpha = max(0.0, min(alpha, 1.0))
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    public func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        setFill()
        ctx?.fillPath()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

public func == (lhs: UIColor, rhs: UIColor) -> Bool {
    return lhs.isEqual(rhs)
}
