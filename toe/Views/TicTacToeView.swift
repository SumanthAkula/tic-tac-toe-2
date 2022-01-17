//
//  ContentView.swift
//  toe
//
//  Created by Sumo Akula on 12/22/21.
//

import SwiftUI

struct TicTacToeView: View {
    @EnvironmentObject var game: TicTacToeGame
    @State private var showingResetGameAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("\(self.game.gameOver ? "Game over!" : "\(self.game.turn.rawValue)'s turn")")
                .font(.headline)
            // MARK: - game board
            GameBoardView()
            
            // MARK: - game reset button
            Button("Reset game") {
                self.showingResetGameAlert.toggle()
            }
            .buttonStyle(.borderedProminent)
            .alert("Reset game?", isPresented: self.$showingResetGameAlert) {
                Button("Yes", role: .destructive, action: self.game.resetGame)
                Button("No", role: .cancel) { }
            } message: {
                Text("Tapping 'Yes' will reset the game board! Are you sure you wanna do that?")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
