import SwiftUI

/// Manages the player's score (wins, losses, draws) with persistence via `@AppStorage`.
///
/// Each counter is automatically persisted to `UserDefaults` so the score
/// survives between app sessions.
class ScoreManager: ObservableObject {
    @AppStorage("wins") var wins: Int = 0
    @AppStorage("losses") var losses: Int = 0
    @AppStorage("draws") var draws: Int = 0

    /// Increments the win counter by 1.
    func recordWin() {
        wins += 1
    }

    /// Increments the loss counter by 1.
    func recordLoss() {
        losses += 1
    }

    /// Increments the draw counter by 1.
    func recordDraw() {
        draws += 1
    }

    /// Resets all counters to zero.
    func reset() {
        wins = 0
        losses = 0
        draws = 0
    }
}
