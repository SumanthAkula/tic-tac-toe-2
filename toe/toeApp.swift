//
//  toeApp.swift
//  toe
//
//  Created by Sumo Akula on 12/22/21.
//

import SwiftUI

@main
struct toeApp: App {
    @StateObject private var game = TicTacToeGame()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TicTacToeView()
                    .environmentObject(game)
                    .navigationTitle(Text("\(self.game.winner == nil ? "Tic Tac Toe" : "\(self.game.winner!.rawValue) Won!")"))
                    .navigationBarTitleDisplayMode(.large)
            }
            .navigationViewStyle(.stack)
//            .border(Color.red)
        }
    }
}
