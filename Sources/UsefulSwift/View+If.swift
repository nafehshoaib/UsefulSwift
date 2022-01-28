//
//  View+If.swift
//  
//
//  Created by Nafeh Shoaib on 3/9/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func `if`<IfContent, ElseContent>(_ condition: Bool, _ ifTransform: (Self) -> IfContent, else elseTransform: (Self) -> ElseContent) -> some View where IfContent: View, ElseContent: View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    @ViewBuilder
    public func `if`<IfContent>(_ condition: Bool, _ ifTransform: (Self) -> IfContent) -> some View where IfContent: View {
        if condition {
            ifTransform(self)
        } else {
            self
        }
    }
}
