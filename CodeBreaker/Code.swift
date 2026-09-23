//
//  Code.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/21/26.
//


import Foundation

struct Code {
    static let empty: Block = "clear"
    
    var kind: Kind
    var blocks: [Block] = Array(repeating: Code.empty, count: 4)
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt([MatchOption])
        case unknown
    }
    
    mutating func createMasterCode(from blockChoices: [Block]) {
        for index in blocks.indices {
            blocks[index] = blockChoices.randomElement() ?? Code.empty
        }
    }
    
    mutating func resetGuess() {
        blocks = Array(repeating: Code.empty, count: blocks.count)
    }
    
    var comparisonResults: [MatchOption]? {
        switch kind {
        case .attempt(let matches): return matches
        default: return nil
        }
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    func compareBlocks(against: Code) -> [MatchOption] {
        var blocksToCompareAgainst = against.blocks
        
        let resultsReversed = blocks.indices.reversed().map { index in
            if blocksToCompareAgainst.count > index, blocksToCompareAgainst[index] == blocks[index] {
                blocksToCompareAgainst.remove(at: index)
                return MatchOption.exact
            } else {
                return MatchOption.nomatch
            }
        }
        
        let results = Array(resultsReversed.reversed())
        return blocks.indices.map { index in
            if results[index] != .exact, let matchIndex = blocksToCompareAgainst.firstIndex(of: blocks[index]) {
                blocksToCompareAgainst.remove(at: matchIndex)
                return .inexact
            } else {
                return results[index]
            }
        }
    }
}
