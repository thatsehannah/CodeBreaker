//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/13/26.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game = CodeBreaker(isEmojiGame: Bool.random())
    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var hideMostrRecentResult = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        Button("Guess", action: makeGuess)
                            .flexibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        let showResults = !hideMostrRecentResult || index != game.attempts.count - 1
                        if showResults, let results = game.attempts[index].comparisonResults {
                            MatchOptionResults(results: results)
                        }
                    }
                    .transition(AnyTransition.attemptTransition(game.isOver))
                }
            }
            if (!game.isOver) {
                BlockChooser(choices: game.blockChoices, onSelect: changeBlockAtSelection)
                    .transition(.blockChooserTransition) // point of origin is the upper left corner, so a positive y is down, and negative y is up
            }
            
            Button("Restart Game", systemImage: "arrow.circlepath", action: restartGame)
        }
        .padding()
    }
    
    func changeBlockAtSelection(to block: Block) {
        game.setGuessBlock(block, at: selection)
        selection = (selection + 1) % game.blockChoices.count
        
    }
    
    func restartGame() {
        withAnimation(.restart) {
            restarting = game.isOver
            game = CodeBreaker(isEmojiGame: Bool.random())
            selection = 0
        } completion: {
            withAnimation(.restart) {
                
                restarting = false
            }
        }
    }
    
    func makeGuess() {
        withAnimation(.guess) {
            game.submitGuess()
            selection = 0
            hideMostrRecentResult = true
        } completion: {
            withAnimation(.guess) {
                hideMostrRecentResult = false
            }
        }
    }
    
    func convertStringToColor(for blocks: [Block]) -> [Color] {
        return blocks.map { block in
            if let color = Color(name: block) {
                return color
            }
            
            return Color.clear
        }
    }
}



#Preview {
    CodeBreakerView()
}
