//
//  FullWidthButtonStyle.swift
//  
//
//  Created by Nafeh Shoaib on 4/3/22.
//

import SwiftUI

public struct FullWidthButtonStyle: ButtonStyle {
    
    public var foregroundColor: Color
    public var backgroundColor: Color
    public var height: CGFloat
    public var cornerRadius: CGFloat
    
    public init(foregroundColor: Color = .white,
                backgroundColor: Color = .accentColor,
                height: CGFloat = 50,
                cornerRadius: CGFloat = 8.0) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
    }
}

extension ButtonStyle where Self == FullWidthButtonStyle {
    public static var fullWidthProminent: FullWidthButtonStyle {
        return FullWidthButtonStyle()
    }
    
    public static var fullWidthBordered: FullWidthButtonStyle {
        return FullWidthButtonStyle(foregroundColor: .accentColor, backgroundColor: .init(.secondarySystemFill))
    }
}

struct FullWidthButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test") {
            
        }
        .buttonStyle(.fullWidthBordered)
        .padding(.horizontal, 20)
    }
}
