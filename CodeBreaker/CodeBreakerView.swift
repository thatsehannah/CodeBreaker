//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 9/13/26.
//

import SwiftUI

extension Color {
    init?(name: String) {
        switch name {
        case "green":
            self = .green
        case "yellow":
            self = .yellow
        case "red":
            self = .red
        case "orange":
            self = .orange
        case "black":
            self = .black
        case "blue":
            self = .blue
        case "clear":
            self = .clear
        default:
            return nil
        }
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game = CodeBreaker(isEmojiGame: Bool.random())
    @State private var selection: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            showView(for: game.masterCode)
            ScrollView {
                if (!game.isOver) {
                    showView(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    showView(for: game.attempts[index])
                }
            }
            BlockChooser(choices: game.blockChoices) { block in
                game.setGuessBlock(block, at: selection)
                selection = (selection + 1) % game.blockChoices.count
            }
            Button("Restart Game") {
                withAnimation {
                    game = CodeBreaker(isEmojiGame: Bool.random())
                }
            }
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.submitGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func convertStringToColor(for blocks: [Block]) -> [Color] {
        return blocks.map { block in
            if let color = Color(name: block) {
                return color
            }
            
            return Color.clear
        }
    }
    
    func showView(for code: Code) -> some View {
        HStack {
            CodeView(code: code, selection: $selection)
            RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let comparisonResults = code.comparisonResults {
                        MatchOptionResults(results: comparisonResults)
                    } else {
                        if (code.kind == .guess) {
                            guessButton
                        }
                    }
                }
        }
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
}

#Preview {
    CodeBreakerView()
}
