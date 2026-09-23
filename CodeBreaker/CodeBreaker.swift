//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/15/26.
//

import Foundation

typealias Block = String

struct CodeBreaker {
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = []
    let blockChoices: [Block] // TODO: change this to a Set
    var isEmojiGame: Bool
    
    init(isEmojiGame: Bool) {
        self.isEmojiGame = isEmojiGame
        
        let pool = isEmojiGame ? ["😭", "😍", "🥺", "🤬", "😃", "😏"] : ["green", "yellow", "red", "orange", "black", "blue"]
        
        self.blockChoices = Array(pool.shuffled().prefix(Int.random(in: 3...6)))
        self.masterCode = Code(kind: .master(isHidden: true), blocks: Array(repeating: Code.empty, count: self.blockChoices.count))
        self.guess = Code(kind: .guess, blocks: Array(repeating: Code.empty, count: self.blockChoices.count))
        masterCode.createMasterCode(from: self.blockChoices)
        print(masterCode)
    }
    
    var isOver: Bool {
        attempts.last?.blocks == masterCode.blocks
    }
    
    mutating func submitGuess() {
        if guess.blocks.count(where: { block in block == Code.empty}) == blockChoices.count {
            return
        }
        
        var attempt = guess
        attempt.kind = .attempt(guess.compareBlocks(against: masterCode))
        attempts.append(attempt)
        
        guess.resetGuess()
        
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessBlock(_ block: Block, at index: Int) {
        guard guess.blocks.indices.contains(index) else { return }
        guess.blocks[index] = block
    }
    
    mutating func changeGuessBlock(at index: Int) {
        let existingBlock = guess.blocks[index]
        if let indexOfExistingBlockInBlockChoices = blockChoices.firstIndex(of: existingBlock) {
            let newBlock = blockChoices[(indexOfExistingBlockInBlockChoices + 1) % blockChoices.count]
            guess.blocks[index] = newBlock
        } else {
            guess.blocks[index] = blockChoices.first ?? Code.empty
        }
    }
}


