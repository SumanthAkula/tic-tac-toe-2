//
//  TicTacToeButton.swift
//  toe
//
//  Created by Sumo Akula on 12/22/21.
//

import SwiftUI

struct TicTacToeButton : View, Identifiable {
    var id: UUID = UUID()
    
    @EnvironmentObject private var game: TicTacToeGame
    public let row: ButtonRow
    public let col: ButtonColumn
    
    init(row: ButtonRow, col: ButtonColumn) {
        self.row = row
        self.col = col
    }
    
    var body: some View {

        Button(self.game.buttonStates[self.row.rawValue][self.col.rawValue].player?.rawValue ?? " ") {
            self.game.buttonTapped(row: row, col: col)
        }
        .foregroundColor(Color.primary)
        .font(.system(size: 64, design: .monospaced))
        .frame(width: 100, height: 110, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.game.buttonStates[self.row.rawValue][self.col.rawValue].color ?? Color.secondary, lineWidth: 1)
        )
    }
}
