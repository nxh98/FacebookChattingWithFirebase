//
//  DictionaryExt.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

extension Dictionary {
    public var allKeys: [Key] {
        return Array(keys)
    }

    public var allValues: [Value] {
        return Array(values)
    }

    public mutating func updateValues(_ dic: [Key: Value]?) {
        if let dic = dic {
            for (key, value) in dic {
                self[key] = value
            }
        }
    }

    public func hasKey(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    public func toJSONData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return nil
        }
    }
}
