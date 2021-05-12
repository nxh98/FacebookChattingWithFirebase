//
//  Range.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/9/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension Range {
    public static func random(from min: Int, to max: Int) -> ClosedRange<Int> {
        let lowerBound = Int.random(min: min, max: max)
        let upperBound = Int.random(min: lowerBound, max: max)
        return lowerBound ... upperBound        
    }
}
