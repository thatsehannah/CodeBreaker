//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/13/26.
//

import SwiftUI

enum MatchOption {
    case nomatch
    case exact
    case inexact
}

struct MatchOptionResults: View {
    // MARK: Data In
    let results: [MatchOption]
    
    // MARK: - Body
    var body: some View {
        HStack {
            // keyword "in" is just a separator; "these are arguments IN in this code"
            ForEach(Array(stride(from: 0, through: results.count, by: 2)), id: \.self) { index in
                VStack {
                    showResultMarker(forBlock: index)
                    showResultMarker(forBlock: index + 1)
                }
            }
        }
        
    }
    
    @ViewBuilder
    func showResultMarker(forBlock block: Int) -> some View {
        
        // counts how many times .exact appears
        let exactCount = results.count { $0 == .exact }
        
        let foundCount = results.count { $0 != .nomatch }
        Circle()
            .fill(exactCount > block ? Color.primary : Color.clear)
            .strokeBorder(foundCount > block ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let blocks = Array(repeating: Color.black, count: 4)
    HStack {
        ForEach(blocks.indices, id: \.self) { index in
            RoundedRectangle(cornerRadius: 10)
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(blocks[index])
        }
        MatchOptionResults(results: [.exact, .inexact, .nomatch, .exact])
    }
    
    
}
