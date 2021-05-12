//
//  NSLock.swift
//  SwiftUtils
//
//  Created by DaoNV on 12/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension NSLock {
    public func sync(_ block: () -> Void) {
        let locked = `try`()
        block()
        if locked {
            unlock()
        }
    }
}
