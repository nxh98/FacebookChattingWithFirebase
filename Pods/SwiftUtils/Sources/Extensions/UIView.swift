//
//  UIView.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

open class IntrinsicContentView: UIView {
    open var intrinsicContentSizeEnabled = true
}

extension UIView {
    public class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    public class func loadNib<T: UIView>() -> T {
        let name = String(describing: self)
        let bundle = Bundle(for: T.self)
        guard let xib = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
            fatalError("Cannot load nib named `\(name)`")
        }
        return xib
    }
}

// MARK: Appearance
extension UIView {
    public func clearSubViews() {
        backgroundColor = UIColor.clear
        for sub in subviews {
            sub.clearSubViews()
        }
    }

    public func border(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }

    public var corner: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }

    public func circle() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }

    public enum BorderPostition {
        case top
        case left
        case bottom
        case right
    }

    public func border(_ pos: BorderPostition, color: UIColor = UIColor.black, width: CGFloat = 0.5, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        let rect: CGRect = {
            switch pos {
            case .top: return CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .left: return CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .bottom: return CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .right: return CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
            }
        }()
        let border = UIView(frame: rect)
        border.backgroundColor = color
        border.autoresizingMask = {
            switch pos {
            case .top: return [.flexibleWidth, .flexibleBottomMargin]
            case .left: return [.flexibleHeight, .flexibleRightMargin]
            case .bottom: return [.flexibleWidth, .flexibleTopMargin]
            case .right: return [.flexibleHeight, .flexibleLeftMargin]
            }
        }()
        addSubview(border)
    }

    public func shadow(color: UIColor, offset: CGSize = CGSize(width: 0, height: 0), opacity: Float = 1.0, radius: CGFloat = 3.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: Layout
extension UIView {
    public func removeSubviewsConstraints() {
        removeConstraints(constraints.filter({ (constraint: NSLayoutConstraint) -> Bool in
            let first = constraint.firstItem as? UIView
            let second = constraint.secondItem as? UIView
            if (first == self && second == self) || (first == self && second == nil) || (first == nil && second == self) {
                return false
            }
            return true
            }))
        for sub in subviews {
            sub.translatesAutoresizingMaskIntoConstraints = false
            sub.removeAllConstraints()
        }
    }

    public func removeAllConstraints() {
        if let view = self as? IntrinsicContentView {
            if view.intrinsicContentSizeEnabled {
                return
            }
        }
        var parent = superview
        while parent != nil {
            for constraint in parent!.constraints {
                let first = constraint.firstItem as? UIView
                let second = constraint.secondItem as? UIView
                if first == self || second == self {
                    parent!.removeConstraint(constraint)
                }
            }
            parent = parent!.superview
        }
        removeConstraints(constraints)
        let subviews = self.subviews
        for sub in subviews {
            sub.removeAllConstraints()
        }
    }
}
