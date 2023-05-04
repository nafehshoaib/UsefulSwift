//
//  EnvironmentBuilder.swift
//  
//
//  Created by Nafeh Shoaib on 5/3/23.
//

import SwiftUI

@resultBuilder
public struct ObservableBuilder {
    public static func buildBlock(_ components: (any ObservableObject)...) ->  [any ObservableObject] {
        return components
    }
}

extension View {
    func setEnvironmentObjects(@ObservableBuilder objects: () -> [any ObservableObject]) -> any View {
        let s: any View = self
        
        return objects().reduce(s) { $0.environmentObject($1) }
    }
    
    /// Adds EnvironmentObjects in order. Warning: Uses `AnyView()`.
    public func environmentObjects(@ObservableBuilder objects: () -> [any ObservableObject]) -> some View {
        return AnyView(setEnvironmentObjects(objects: objects))
    }
}

struct ObservableBuilderBuilder_Previews: PreviewProvider {
    class ViewModel: ObservableObject {
        @Published var test = false
    }
    
    class ViewModel2: ObservableObject {
        @Published var test = true
    }
    
    struct DemoView: View {
        @EnvironmentObject var viewModel: ViewModel
        @EnvironmentObject var viewModel2: ViewModel2
        
        var body: some View {
            VStack {
                Text(viewModel.test ? "Yes" : "No")
                Text(viewModel2.test ? "Yes" : "No")
            }
        }
    }
    
    static var previews: some View {
        DemoView()
            .environmentObjects {
                ViewModel()
                ViewModel2()
            }
    }
}
