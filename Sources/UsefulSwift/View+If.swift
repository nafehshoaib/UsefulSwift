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
    
    @ViewBuilder
    public func `if`<Variable, IfContent>(`let` variable: Variable?, _ ifTransform: (Variable, Self) -> IfContent) -> some View where IfContent: View {
        if let variable = variable {
            ifTransform(variable, self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func `if`<Variable, IfContent, ElseContent>(`let` variable: Variable?, _ ifTransform: (Variable, Self) -> IfContent, else elseTransform: (Self) -> ElseContent) -> some View where IfContent: View, ElseContent: View {
        if let variable = variable {
            ifTransform(variable, self)
        } else {
            elseTransform(self)
        }
    }
}

struct ViewIf_Previews: PreviewProvider {
    struct PreviewView: View {
        @State var toggle = false
        @State var variable: Color?
        
        var body: some View {
            List {
                Text("If")
                    .if(toggle) {
                        $0.bold()
                    }
                Text("If + Else")
                    .if(toggle) {
                        $0.foregroundColor(.blue)
                    } else: {
                        $0
                            .foregroundColor(.red)
                            .bold()
                    }
                Text("If let ")
                    .if(let: variable) { variable, text in
                        text
                            .foregroundColor(variable)
                    }
                Text("If let Else")
                    .if(let: variable) { variable, text in
                        text
                            .foregroundColor(variable)
                    } else: { text in
                        text
                            .bold()
                    }
            }
        }
    }
    
    static var previews: some View {
        PreviewView()
    }
}
