//
//  Label.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/5/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

open class Label: UILabel {
    open var edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = edgeInsets.inset(bounds)
        rect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        return edgeInsets.inverse.inset(rect)
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: edgeInsets.inset(rect))
    }

    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += (edgeInsets.left + edgeInsets.right)
        size.height += (edgeInsets.top + edgeInsets.bottom)
        return size
    }
}
