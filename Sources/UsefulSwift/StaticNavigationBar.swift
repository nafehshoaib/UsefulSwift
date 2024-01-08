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


public struct ScrollStatusBarModifier: ViewModifier {
    
    @Binding var id: Int?
    @State var opacity: Double = 0
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            if let id = id {
                Color.clear
                    .edgesIgnoringSafeArea([.horizontal, .top])
                    .frame(height: 1)
                    .background(.ultraThinMaterial)
                    .opacity(opacity)
                    .zIndex(1)
            }
            content
        }
        .onChange(of: id) { new in
            guard let new = new else {
                return
            }
            
            let op = min(Double(new), 1)
            
            if op != opacity {
                withAnimation {
                    opacity = op
                }
            }
        }
    }
}

extension View {
    /// Enables navbar to move with scroll view. Needs to be used with `StaticNavigationBar`.
    public func scrollStatusBar(id: Binding<Int?>) -> some View {
        self
            .navigationBarHidden(true)
            .modifier(ScrollStatusBarModifier(id: id))
    }
}

@available(iOS 17.0, *)
fileprivate struct PreviewView: View {
    
    @State var showSheet = false
    @State var position: Int?
    
    var body: some View {
        ScrollView {
            Group {
                StaticNavigationBar("Today", prompt: "Friday, April 1") {
                    Circle()
                        .frame(width: 50, height: 50)
                }
                .id(0)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(1)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(2)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(3)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(4)
                    .onTapGesture {
                        showSheet = true
                    }
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(5)
                    .onTapGesture {
                        showSheet = true
                    }
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .frame(height: 200)
                    .padding(20)
                    .id(6)
                    .onTapGesture {
                        showSheet = true
                    }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $position)
        .scrollStatusBar(id: $position)
        .sheet(isPresented: $showSheet, content: {
            Text("Hello World")
        })
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        PreviewView()
    } else {
        // Fallback on earlier versions
        Text("Hello world")
    }
}

#Preview {
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

#Preview {
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
#endif
