//
//  Double+Round.swift
//  
//
//  Created by Nafeh Shoaib on 2020-09-01.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    public func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public func isWithin(percent: Double, of number: Double) -> Bool {
        let decimalPercent = percent / 2.0
        let highRange = number * (1.0 + decimalPercent)
        let lowRange = number * (1.0 - decimalPercent)
        return lowRange <= self && self <= highRange
    }
    
    public func isWithin(interval: Double, of number: Double) -> Bool {
        let buffer = interval / 2
        return ((self - buffer)...(self+buffer)).contains(number)
    }
}
