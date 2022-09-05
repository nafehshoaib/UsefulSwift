//
//  AnyEncodable.swift
//  
//
//  Created by Nafeh Shoaib on 9/5/22.
//

import Foundation

/// Type-erased Encodable struct
/// Swift Forums source: https://forums.swift.org/t/how-to-encode-objects-of-unknown-type/12253
public struct AnyEncodable: Encodable {
    
    private let encodeAction: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        encodeAction = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try encodeAction(encoder)
    }
}
