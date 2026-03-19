import Foundation

/// Represents the outcome of a Tic-Tac-Toe game.
/// - `.win`: The human player won
/// - `.lose`: The AI won
/// - `.draw`: The game ended in a draw
enum GameResult {
    case win
    case lose
    case draw
}
