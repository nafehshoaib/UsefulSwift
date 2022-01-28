//
//  SwiftDate+RawRepresentable.swift
//  
//
//  Created by Nafeh Shoaib on 7/19/21.
//

import Foundation
import SwiftDate

extension DateInRegion: RawRepresentable {
    public init?(rawValue: String) {
        self.init(rawValue)
    }
    
    public var rawValue: String {
        return self.toString(.dateTime(.full))
    }
}
