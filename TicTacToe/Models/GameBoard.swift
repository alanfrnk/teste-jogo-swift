import Foundation

/// Represents the 3x3 Tic-Tac-Toe game board.
///
/// The board is a linear array of 9 positions mapping to a 3x3 grid:
/// ```
/// [0][1][2]
/// [3][4][5]
/// [6][7][8]
/// ```
struct GameBoard {
    /// The 9 cells of the board. `nil` means the cell is empty.
    var cells: [Player?]

    /// All 8 winning combinations: 3 rows, 3 columns, 2 diagonals.
    static let winPatterns: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
        [0, 4, 8], [2, 4, 6]              // diagonals
    ]

    /// Creates a new empty board.
    init() {
        cells = Array(repeating: nil, count: 9)
    }

    /// Returns `true` if the cell at the given index is empty.
    func isEmptyAt(_ index: Int) -> Bool {
        guard index >= 0, index < 9 else { return false }
        return cells[index] == nil
    }

    /// Returns the indices of all empty cells.
    func availableMoves() -> [Int] {
        cells.indices.filter { cells[$0] == nil }
    }

    /// Places the given player's mark at the specified index.
    /// Does nothing if the index is out of range or the cell is already occupied.
    mutating func place(_ player: Player, at index: Int) {
        guard index >= 0, index < 9, cells[index] == nil else { return }
        cells[index] = player
    }

    /// Checks all winning combinations and returns the winner, or `nil` if there is none.
    func checkWinner() -> Player? {
        for pattern in Self.winPatterns {
            let a = cells[pattern[0]]
            let b = cells[pattern[1]]
            let c = cells[pattern[2]]
            if let player = a, player == b, player == c {
                return player
            }
        }
        return nil
    }

    /// Returns `true` if the board is full and there is no winner (draw).
    func isDraw() -> Bool {
        availableMoves().isEmpty && checkWinner() == nil
    }
}
