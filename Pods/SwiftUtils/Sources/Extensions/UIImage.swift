//
//  UIImage.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/23/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIImage {
    public func scaleToSize(_ newSize: CGSize, aspectFill: Bool = false) -> UIImage {
        let scaleFactorWidth = newSize.width / size.width
        let scaleFactorHeight = newSize.height / size.height
        let scaleFactor = aspectFill ? max(scaleFactorWidth, scaleFactorHeight) : min(scaleFactorWidth, scaleFactorHeight)

        var scaledSize = size
        scaledSize.width *= scaleFactor
        scaledSize.height *= scaleFactor

        UIGraphicsBeginImageContextWithOptions(scaledSize, false, UIScreen.main.scale)
        let scaledImageRect = CGRect(x: 0.0, y: 0.0, width: scaledSize.width, height: scaledSize.height)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage!
    }
}
