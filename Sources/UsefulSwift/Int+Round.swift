//
//  Int+Round.swift
//  
//
//  Created by Nafeh Shoaib on 1/28/22.
//

import Foundation

extension Int {
    public func isWithin(percent: Double, of number: Int) -> Bool {
        return Double(self).isWithin(percent: percent, of: Double(number))
    }
    
    public func isWithin(interval: Int, of number: Int) -> Bool {
        return Double(self).isWithin(interval: Double(interval), of: Double(number))
    }
}
