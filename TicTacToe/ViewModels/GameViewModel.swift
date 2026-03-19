import SwiftUI

/// Orchestrates the Tic-Tac-Toe game flow, managing turns, board state,
/// win/draw detection, and score updates.
class GameViewModel: ObservableObject {
    @Published var board: GameBoard
    @Published var isPlayerTurn: Bool
    @Published var gameResult: GameResult?

    private let scoreManager: ScoreManager

    /// Creates a new view model ready for a fresh game.
    /// - Parameter scoreManager: The shared score manager used to record results.
    init(scoreManager: ScoreManager) {
        self.scoreManager = scoreManager
        self.board = GameBoard()
        self.isPlayerTurn = true
        self.gameResult = nil
    }

    // MARK: - Player Move

    /// Processes a tap on the cell at the given index.
    ///
    /// The move is ignored when:
    /// - It is not the player's turn
    /// - The cell is already occupied
    /// - The game is already over
    func playerMove(at index: Int) {
        guard isPlayerTurn, gameResult == nil, board.isEmptyAt(index) else { return }

        board.place(.x, at: index)
        isPlayerTurn = false

        if checkEndOfGame() { return }

        // Trigger AI move after a short delay for better UX
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.aiMove()
        }
    }

    // MARK: - AI Move

    /// Executes the AI's turn by selecting the best available move.
    func aiMove() {
        guard gameResult == nil else { return }

        let move = AIPlayer.bestMove(board: board)
        guard move >= 0 else { return }

        board.place(.o, at: move)

        if checkEndOfGame() { return }

        isPlayerTurn = true
    }

    // MARK: - Reset

    /// Resets the board to an empty state and gives the first turn to the player.
    func resetGame() {
        board = GameBoard()
        isPlayerTurn = true
        gameResult = nil
    }

    // MARK: - End-of-Game Detection

    /// Checks for a winner or draw after the latest move.
    /// Updates `gameResult` and records the outcome in `ScoreManager` when the game ends.
    /// - Returns: `true` if the game has ended, `false` otherwise.
    @discardableResult
    private func checkEndOfGame() -> Bool {
        if let winner = board.checkWinner() {
            switch winner {
            case .x:
                gameResult = .win
                scoreManager.recordWin()
            case .o:
                gameResult = .lose
                scoreManager.recordLoss()
            }
            return true
        }

        if board.isDraw() {
            gameResult = .draw
            scoreManager.recordDraw()
            return true
        }

        return false
    }
}
