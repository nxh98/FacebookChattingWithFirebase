//
//  CustomLine.swift
//  FinalProject
//
//  Created by NXH on 10/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class CustomLine: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.gray.cgColor)
            context.setLineWidth(0.3)
            context.move(to: CGPoint(x: 0, y: bounds.height / 2))
            context.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
            context.strokePath()
        }
    }
}
