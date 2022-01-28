//
//  Sequence+KeyPath.swift
//  
//
//  Created by Nafeh Shoaib on 2021-11-25.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}
