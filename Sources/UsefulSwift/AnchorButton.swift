//
//  AnchorButton.swift
//
//
//  Created by Nafeh Shoaib on 3/25/22.
//

import SwiftUI

public struct AnchorButton<Label>: ViewModifier where Label: View {
    var items: [AnchorItem<Label>]
    
    public init(@ArrayBuilder<AnchorItem<Label>> items: () -> [AnchorItem<Label>]) {
        self.items = items()
    }
    
    public init(isEnabled: Bool = true,
                @ViewBuilder button: () -> Button<Label>) {
        self.init {
            AnchorItem(isEnabled: isEnabled) {
                button()
            }
        }
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .bottom)) {
            content
                .frame(maxWidth: .infinity)
            VStack(spacing: 8.0) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    item.button
                        .buttonStyle(item.style)
                        .disabled(!item.isEnabled)
                }
            }
            .padding(20)
            .background(Material.bar)
        }
    }
}

public struct AnchorItem<Label> where Label: View {
    var isEnabled: Bool
    
    var style: FullWidthButtonStyle
    var button: Button<Label>
    
    public init(isEnabled: Bool = true, style: FullWidthButtonStyle = .fullWidthProminent, @ViewBuilder button: () -> Button<Label>) {
        self.isEnabled = isEnabled
        self.style = style
        self.button = button()
    }
}

extension ScrollView {
    @ViewBuilder
    public func anchorButton<Label: View>(isEnabled: Bool = true, includeSpacer: Bool = false, @ViewBuilder button: () -> Button<Label>) -> some View {
        if includeSpacer {
            ScrollView<HStack<TupleView<(Content, Spacer)>>> {
                HStack {
                    content
                    Spacer()
                }
            }
            .modifier(AnchorButton(isEnabled: isEnabled, button: button))
        } else {
            modifier(AnchorButton(isEnabled: isEnabled, button: button))
        }
    }
    
    @ViewBuilder
    public func anchorButton<Label: View>(includeSpacer: Bool = false,
                                          @ArrayBuilder<AnchorItem<Label>> items: () -> [AnchorItem<Label>]) -> some View {
        if includeSpacer {
            ScrollView<HStack<TupleView<(Content, Spacer)>>> {
                HStack {
                    content
                    Spacer()
                }
            }
            .modifier(AnchorButton(items: items))
        } else {
            modifier(AnchorButton(items: items))
        }
    }
}

struct AnchorButton_Previews: PreviewProvider {
    struct Preview: View {
        
        @State var show = false
        
        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Hello")
                    }
                    NavigationLink(isActive: $show) {
                        EmptyView()
                    } label: {
                        EmptyView()
                    }
                    
                }
                .anchorButton {
                    Button("Next") {
                        show = true
                    }
                }
                .navigationTitle("Study")
            }
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
