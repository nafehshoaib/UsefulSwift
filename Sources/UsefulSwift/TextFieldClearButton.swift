//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 4/3/22.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !text.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                    }
                }
            }
    }
}

extension View {
    @ViewBuilder
    func clearableTextField(_ bool: Bool = true, text: Binding<String>) -> some View {
        if bool {
            modifier(TextFieldClearButton(text: text))
        } else {
            self
        }
    }
}
