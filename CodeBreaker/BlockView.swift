//
//  BlockView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/21/26.
//

import SwiftUI

struct BlockView: View {
    // MARK: Data In
    let block: Block
    
    // MARK: Data owned by me
    var isEmoji: Bool {
        Color(name: block) == nil
    }
    
    // MARK: - Body
    let blockShape = Circle()
    
    var body: some View {
        blockShape
            .foregroundStyle(isEmoji ? Color.clear : (Color(name: block) ?? Color.clear))
            .contentShape(blockShape)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                if isEmoji {
                    Text(block)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9/120)
                }
            }
            .overlay {
                if block == Code.empty {
                    blockShape
                        .strokeBorder(Color.gray)
                }
            }
    }
}

#Preview {
    BlockView(block: "green")
        .padding()
    BlockView(block: "😆")
        .padding()
}
