//
//  String+Capitalizations.swift
//  
//
//  Created by Nafeh Shoaib on 2020-12-07.
//

import Foundation

extension String {
    public var titleCase: String {
        return replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression, range: self.startIndex ..< self.endIndex).capitalized
    }
    
    public var uppercasedFirstLetter: String {
        if let first = self.first {
            return first.uppercased() + self.dropFirst()
        }
        return self
    }
}
