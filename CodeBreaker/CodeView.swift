//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/21/26.
//

import SwiftUI

struct CodeView: View {
    // MARK: Data in
    let code: Code
    
    // MARK: Data shared with me
    @Binding var selection: Int
    
    // MARK: - Body
    
    var body: some View {
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
    }
    
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}

//#Preview {
//    CodeView()
//}
