//
//  ViewExtensions.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 10/5/26.
//

import SwiftUI

extension View {
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80) -> some View {
        self
            .font(.system(size: maximum))
            .minimumScaleFactor(minimum/maximum)
    }
}

extension Animation {
    static let codeBreaker = Animation.bouncy
    static let guess = Animation.codeBreaker
    static let restart = Animation.codeBreaker
    static let select = Animation.codeBreaker
}

extension AnyTransition {
    static let blockChooserTransition = AnyTransition.offset(x: 0, y: 200)
    
    static func attemptTransition(_ isOver: Bool) -> AnyTransition {
        return AnyTransition.asymmetric(
            insertion: isOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing))
    }
}

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
