import SwiftUI

/// The home screen displayed when the app launches.
/// Shows the current score and provides buttons to start a game or reset the score.
struct HomeView: View {
    @EnvironmentObject var scoreManager: ScoreManager

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text("Jogo da Velha")
                .font(.largeTitle.bold())

            // Score display
            HStack(spacing: 24) {
                ScoreItem(title: "Vitórias", value: scoreManager.wins, color: .green)
                ScoreItem(title: "Derrotas", value: scoreManager.losses, color: .red)
                ScoreItem(title: "Empates", value: scoreManager.draws, color: .orange)
            }

            // Action buttons
            VStack(spacing: 16) {
                NavigationLink {
                    GameView(scoreManager: scoreManager)
                        .environmentObject(scoreManager)
                } label: {
                    Text("Jogar")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                Button {
                    scoreManager.reset()
                } label: {
                    Text("Zerar Placar")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

// MARK: - Score Item

private struct ScoreItem: View {
    let title: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.title.bold())
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(ScoreManager())
    }
}
