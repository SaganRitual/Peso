// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var gameSettings = GameSettings()
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            SpriteKitView()
                .padding()
            SidebarView()
                .frame(width: 400)
        }
        .padding()
        .environmentObject(GameController(gameSettings: gameSettings))
    }
}
