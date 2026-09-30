//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/21/26.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View {
    // MARK: Data in
    let code: Code
    
    // MARK: Data shared with me
    @Binding var selection: Int
    
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    init(code: Code, selection: Binding<Int> = .constant(-1), @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }) {
        self.code = code
        self._selection = selection // underscore variable is hidden. when I pass a binding to an init and I want to set that to the value of the binding, the underscore value needs to be set. underscore represents the binding, where the non-underscore is a computed variable that uses the underscore variable
        self.ancillaryView = ancillaryView
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(code.blocks.indices, id: \.self) { index in
                BlockView(block: code.blocks[index])
                    .padding(Selection.border)
                    .background {
                        if selection == index, code.kind == .guess {
                            Selection.shape
                                .foregroundStyle(Selection.color)
                        }
                        
                    }
                    .overlay {
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
            
        }
    }
}
    
fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

//#Preview {
//    CodeView()
//}
