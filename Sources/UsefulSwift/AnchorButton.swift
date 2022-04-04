//
//  AnchorButton.swift
//
//
//  Created by Nafeh Shoaib on 3/25/22.
//

import SwiftUI

public struct AnchorButton<Label: View>: ViewModifier {
    
    @Binding var isEnabled: Bool
    
    var button: Button<Label>
    
    public init(isEnabled: Binding<Bool> = .constant(true), @ViewBuilder button: () -> Button<Label>) {
        self._isEnabled = isEnabled
        self.button = button()
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .bottom)) {
            content
                .frame(maxWidth: .infinity)
            button
                .buttonStyle(.fullWidthProminent)
                .disabled(!isEnabled)
                .padding(20)
                .background(Material.bar)
        }
    }
}

extension ScrollView {
    @ViewBuilder
    public func anchorButton<Label: View>(includeSpacer: Bool = false, @ViewBuilder button: () -> Button<Label>) -> some View {
        if includeSpacer {
            ScrollView<HStack<TupleView<(Content, Spacer)>>> {
                HStack {
                    content
                    Spacer()
                }
            }
            .modifier(AnchorButton(button: button))
        } else {
            modifier(AnchorButton(button: button))
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
