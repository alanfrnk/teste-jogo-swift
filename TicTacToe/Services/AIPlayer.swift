import Foundation

/// AI opponent logic for the Tic-Tac-Toe game.
///
/// Uses a priority-based strategy:
/// 1. Win — if the AI can complete three in a row, take that move
/// 2. Block — if the player can win next turn, block it
/// 3. Strategic position — prefer center > corners > sides
struct AIPlayer {

    /// Returns the index of the best move for the AI (`.o`) on the given board.
    ///
    /// - Parameter board: The current game board state.
    /// - Returns: The index (0-8) of the chosen cell, or `-1` if no moves are available.
    static func bestMove(board: GameBoard) -> Int {
        let available = board.availableMoves()
        guard !available.isEmpty else { return -1 }

        // 1. Try to win
        if let winMove = findWinningMove(for: .o, board: board, available: available) {
            return winMove
        }

        // 2. Block the player from winning
        if let blockMove = findWinningMove(for: .x, board: board, available: available) {
            return blockMove
        }

        // 3. Strategic pick: center > corners > sides
        let center = 4
        if available.contains(center) { return center }

        let corners = [0, 2, 6, 8]
        if let corner = corners.first(where: { available.contains($0) }) {
            return corner
        }

        let sides = [1, 3, 5, 7]
        if let side = sides.first(where: { available.contains($0) }) {
            return side
        }

        // Fallback (should not be reached given the guard above)
        return available[0]
    }

    // MARK: - Private Helpers

    /// Checks whether the given player can win in one move.
    /// Returns the winning cell index, or `nil` if none exists.
    private static func findWinningMove(
        for player: Player,
        board: GameBoard,
        available: [Int]
    ) -> Int? {
        for move in available {
            var copy = board
            copy.place(player, at: move)
            if copy.checkWinner() == player {
                return move
            }
        }
        return nil
    }
}
