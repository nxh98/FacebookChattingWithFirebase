//
//  Array.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension Array {

    public mutating func shuffle() {
        for i in (1 ..< count).reversed() {
            let j = Int.random(max: i - 1)
            swapAt(i, j)
        }
    }

    public func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }

    public func toJSONString() -> String? {
        guard let data = toJSONData() else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
    
    public func toJSONData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return data
        } catch {
            return nil
        }
    }
}

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) -> Element? {
        guard let idx = index(of: element) else {
            return nil
        }
        return self.remove(at: idx)
    }
}
