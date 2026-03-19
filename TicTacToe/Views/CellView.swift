import SwiftUI

/// Renders a single cell of the Tic-Tac-Toe board.
/// Displays "X" (blue), "O" (red), or blank depending on the cell state.
struct CellView: View {
    let player: Player?

    var body: some View {
        Text(player?.rawValue ?? "")
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .foregroundColor(player == .x ? .blue : .red)
            .frame(width: 80, height: 80)
            .background(Color(.systemBackground))
            .border(Color.gray, width: 1)
            .accessibilityLabel(accessibilityText)
    }

    private var accessibilityText: String {
        switch player {
        case .x: return "X"
        case .o: return "O"
        case .none: return "Empty"
        }
    }
}

#Preview("X Cell") {
    CellView(player: .x)
}

#Preview("O Cell") {
    CellView(player: .o)
}

#Preview("Empty Cell") {
    CellView(player: nil)
}
