//
//  Array+Closest.swift
//  
//
//  Created by Nafeh Shoaib on 1/28/22.
//

import Foundation

extension Array where Element == Int {
    public func closest(to value: Int) -> Int? {
        return self.enumerated().min(by: { abs($0.1 - value) < abs($1.1 - value)})?.element
    }
}
