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
    
    // MARK: Data owned by me
    @Namespace private var selectionNamespace // this is for matchedGeometryEffect, which requires a namespace. the id required my matchedGeometryEffect can potentially be used in other parts of the code, but adding this namespace locks it to this particular usage
    
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
                BlockView(block: code.isHidden ? Code.empty : code.blocks[index])
                    .padding(Selection.border)
                    .background { // selection background
                        Group { // Group is a container that can group views together without changing the layout. used here to apply the animation strictly to the background and not the whole BlockView itself
                            if selection == index, code.kind == .guess {
                                Selection.shape
                                    .foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace) 
                            }
                        }
                        .animation(.select, value: selection)
                    }
                    
                    .overlay { // Hidden code
                        Selection.shape
                            .foregroundStyle(code.isHidden ? Color.gray : .clear)
//                            .transaction { transaction in
//                                if code.isHidden { // this occurs when the isHidden property is being set to true
//                                    transaction.animation = nil
//                                }
//                            }
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
