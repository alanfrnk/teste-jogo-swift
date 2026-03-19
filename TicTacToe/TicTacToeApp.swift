import SwiftUI

@main
struct TicTacToeApp: App {
    @StateObject private var scoreManager = ScoreManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(scoreManager)
        }
    }
}
