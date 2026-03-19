import SwiftUI

/// The main game screen displaying the 3x3 board, current score, and result overlay.
struct GameView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @StateObject private var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss

    /// Creates a `GameView` with a `GameViewModel` backed by the given `ScoreManager`.
    init(scoreManager: ScoreManager) {
        _viewModel = StateObject(wrappedValue: GameViewModel(scoreManager: scoreManager))
    }

    private let columns = Array(repeating: GridItem(.fixed(80), spacing: 4), count: 3)

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                // Score display
                HStack(spacing: 24) {
                    ScoreLabel(title: "Vitórias", value: scoreManager.wins, color: .green)
                    ScoreLabel(title: "Derrotas", value: scoreManager.losses, color: .red)
                    ScoreLabel(title: "Empates", value: scoreManager.draws, color: .orange)
                }
                .padding(.top)

                // 3x3 board grid
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(0..<9, id: \.self) { index in
                        Button {
                            viewModel.playerMove(at: index)
                        } label: {
                            CellView(player: viewModel.board.cells[index])
                        }
                        .accessibilityLabel("Cell \(index)")
                    }
                }

                Spacer()
            }
            .padding()

            // Result overlay
            if let result = viewModel.gameResult {
                ResultOverlay(result: result) {
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(viewModel.gameResult != nil)
    }
}

// MARK: - Score Label

private struct ScoreLabel: View {
    let title: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.title2.bold())
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        GameView(scoreManager: ScoreManager())
            .environmentObject(ScoreManager())
    }
}
