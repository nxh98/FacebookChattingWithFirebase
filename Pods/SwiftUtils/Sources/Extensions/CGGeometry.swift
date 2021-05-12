//
//  CGPoint.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/8/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension CGPoint {
    public var isZero: Bool {
        return x == 0 && y == 0
    }
}

public prefix func - (point: CGPoint) -> CGPoint {
    return CGPoint(x: -point.x, y: -point.y)
}

public func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

public func += (lhs: inout CGPoint, rhs: CGPoint) -> CGPoint {
    lhs.x += rhs.x
    lhs.y += rhs.y
    return lhs
}

public func += (lhs: inout CGPoint, rhs: CGSize) -> CGPoint {
    lhs.x += rhs.width
    lhs.y += rhs.height
    return lhs
}

public func += (lhs: inout CGPoint, rhs: CGVector) -> CGPoint {
    lhs.x += rhs.dx
    lhs.y += rhs.dy
    return lhs
}

public func += (lhs: inout CGPoint, rhs: CGFloat) -> CGPoint {
    lhs.x += rhs
    lhs.y += rhs
    return lhs
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

public func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
}

public func -= (lhs: inout CGPoint, rhs: CGPoint) -> CGPoint {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
    return lhs
}

public func -= (lhs: inout CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

public func -= (lhs: inout CGPoint, rhs: CGVector) -> CGPoint {
    lhs.x -= rhs.dx
    lhs.y -= rhs.dy
    return lhs
}

public func -= (lhs: inout CGPoint, rhs: CGFloat) -> CGPoint {
    lhs.x -= rhs
    lhs.y -= rhs
    return lhs
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

public func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
}

public func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
}

public func *= (lhs: inout CGPoint, rhs: CGFloat) -> CGPoint {
    lhs.x *= rhs
    lhs.y *= rhs
    return lhs
}

public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func /= (lhs: inout CGPoint, rhs: CGFloat) -> CGPoint {
    lhs.x /= rhs
    lhs.y /= rhs
    return lhs
}

public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

extension CGSize {
    public init(size: CGFloat) {
        self.init(width: size, height: size)
    }

    public var isZero: Bool {
        return width <= 0 || height <= 0
    }
}

public func += (lhs: inout CGSize, rhs: CGSize) -> CGSize {
    lhs.width += rhs.width
    lhs.height += rhs.height
    return lhs
}

public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func -= (lhs: inout CGSize, rhs: CGSize) -> CGSize {
    lhs.width -= rhs.width
    lhs.height -= rhs.height
    return lhs
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func *= (lhs: inout CGSize, rhs: CGFloat) -> CGSize {
    lhs.width *= rhs
    lhs.height *= rhs
    return lhs
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func /= (lhs: inout CGSize, rhs: CGFloat) -> CGSize {
    lhs.width /= rhs
    lhs.height /= rhs
    return lhs
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
}

extension CGVector {
    public var isZero: Bool {
        return dx == 0 && dy == 0
    }
}

public prefix func - (lhs: CGVector) -> CGVector {
    return CGVector(dx: -lhs.dx, dy: -lhs.dy)
}

public func == (lhs: CGVector, rhs: CGVector) -> Bool {
    return lhs.dx == rhs.dx && lhs.dy == rhs.dy
}

public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func += (lhs: inout CGVector, rhs: CGVector) -> CGVector {
    lhs.dx += rhs.dx
    lhs.dy += rhs.dy
    return lhs
}

public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

public func * (lhs: CGVector, rhs: CGVector) -> CGFloat {
    return lhs.dx * rhs.dy + lhs.dy * rhs.dx
}

public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
}

public func /= (lhs: inout CGVector, rhs: CGFloat) -> CGVector {
    lhs.dx /= rhs
    lhs.dy /= rhs
    return lhs
}

extension CGRect {
    public var mid: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    public var topLeft: CGPoint {
        return CGPoint(x: minX, y: minY)
    }

    public var topCenter: CGPoint {
        return CGPoint(x: midX, y: minY)
    }

    public var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }

    public var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }

    public var bottomCenter: CGPoint {
        return CGPoint(x: midX, y: maxY)
    }

    public var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
}

public func + (lhs: CGRect, rhs: CGPoint) -> CGRect {
    let origin = CGPoint(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y)
    return CGRect(origin: origin, size: lhs.size)
}

public func + (lhs: CGRect, rhs: CGVector) -> CGRect {
    let origin = CGPoint(x: lhs.origin.x + rhs.dx, y: lhs.origin.y + rhs.dy)
    return CGRect(origin: origin, size: lhs.size)
}

public func + (lhs: CGRect, rhs: CGSize) -> CGRect {
    let size = CGSize(width: lhs.size.width + rhs.width, height: lhs.size.height + rhs.height)
    return CGRect(origin: lhs.origin, size: size)
}

public func - (lhs: CGRect, rhs: CGPoint) -> CGRect {
    let origin = CGPoint(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y)
    return CGRect(origin: origin, size: lhs.size)
}

public func - (lhs: CGRect, rhs: CGVector) -> CGRect {
    let origin = CGPoint(x: lhs.origin.x - rhs.dx, y: lhs.origin.y - rhs.dy)
    return CGRect(origin: origin, size: lhs.size)
}

public func - (lhs: CGRect, rhs: CGSize) -> CGRect {
    let size = CGSize(width: lhs.size.width - rhs.width, height: lhs.size.height - rhs.height)
    return CGRect(origin: lhs.origin, size: size)
}
