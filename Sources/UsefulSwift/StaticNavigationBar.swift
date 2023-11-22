//
//  StaticNavigationBar.swift
//
//
//  Created by Nafeh Shoaib on 4/1/22.
//

import SwiftUI

#if os(iOS)
public struct StaticNavigationBar<Content>: View where Content: View {
    
    var title: String
    var prompt: String?
    
    var alignment: VerticalAlignment
    
    let button: Content
    
    public init(_ title: String, prompt: String? = nil, alignment: VerticalAlignment = .bottom, @ViewBuilder button: () -> Content) {
        self.title = title
        self.prompt = prompt
        self.alignment = alignment
        self.button = button()
    }
    
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: NavbarScrollPreference.self,
                                value: -proxy.frame(in: .named("card-list")).minY)
            }
            .frame(height: 0)
            HStack(alignment: alignment) {
                VStack(alignment: .leading, spacing: 5.0) {
                    if let prompt = prompt {
                        Text(prompt.uppercased())
                            .font(.footnote.bold())
                            .foregroundColor(.secondary)
                    }
                    Text(title)
                        .font(.largeTitle.bold())
                }
                Spacer()
                button
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
        }
    }
}

public struct NavbarScrollPreference: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
}

public struct StaticNavbarModifier: ViewModifier {
    @State private var topOpacity: Double = 0
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            Color.clear
                .edgesIgnoringSafeArea([.horizontal, .top])
                .frame(height: 1)
                .background(.ultraThinMaterial)
                .opacity(topOpacity)
                .zIndex(1)
            content
        }
        .onPreferenceChange(NavbarScrollPreference.self) { new in
            let newOpacity = min(Double(new / 20), 1)
            
            if newOpacity != topOpacity {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.topOpacity = newOpacity
                }
            }
        }
    }
}

extension View {
    /// Enables navbar to move with scroll view. Needs to be used with `StaticNavigationBar`.
    public func staticNavigationBarOnScroll() -> some View {
        self
            .navigationBarHidden(true)
            .modifier(StaticNavbarModifier())
    }
}

struct StaticNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            StaticNavigationBar("Today", prompt: "Friday, April 1") {
                Circle()
                    .frame(width: 50, height: 50)
            }
        }
        ScrollView {
            StaticNavigationBar("Wallet", alignment: .center) {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 30)
            }
        }
    }
}
#endif
