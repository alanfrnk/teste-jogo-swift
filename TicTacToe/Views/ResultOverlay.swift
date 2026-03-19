import SwiftUI

/// Overlay displayed at the end of a game showing the result with animations.
/// Shows "You Win" (green), "You Lose" (red), or "Draw" (orange) with
/// scale and opacity entrance animations, plus a button to return to the home screen.
struct ResultOverlay: View {
    let result: GameResult
    let onReturn: () -> Void

    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .accessibilityHidden(true)

            VStack(spacing: 24) {
                Text(resultText)
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(resultColor)
                    .scaleEffect(isAnimating ? 1.0 : 0.3)
                    .opacity(isAnimating ? 1.0 : 0.0)

                Button(action: onReturn) {
                    Text("Voltar")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(resultColor)
                        .cornerRadius(12)
                }
                .scaleEffect(isAnimating ? 1.0 : 0.3)
                .opacity(isAnimating ? 1.0 : 0.0)
                .accessibilityLabel("Voltar à tela inicial")
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                isAnimating = true
            }
        }
    }

    private var resultText: String {
        switch result {
        case .win: return "You Win"
        case .lose: return "You Lose"
        case .draw: return "Draw"
        }
    }

    private var resultColor: Color {
        switch result {
        case .win: return .green
        case .lose: return .red
        case .draw: return .orange
        }
    }
}

#Preview("Win") {
    ResultOverlay(result: .win, onReturn: {})
}

#Preview("Lose") {
    ResultOverlay(result: .lose, onReturn: {})
}

#Preview("Draw") {
    ResultOverlay(result: .draw, onReturn: {})
}
