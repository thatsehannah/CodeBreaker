//
//  BlockChooser.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/21/26.
//

import SwiftUI

struct BlockChooser: View {
    
    // MARK: Data In
    let choices: [Block]
    
    // MARK: Data Out Function
    let onSelect: ((Block) -> Void)?
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) { block in
                Button {
                    onSelect?(block)
                } label: {
                    BlockView(block: block)
                }
            }
        }
    }
}

//#Preview {
//    BlockChooser()
//}
