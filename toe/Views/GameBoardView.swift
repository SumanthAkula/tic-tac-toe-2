//
//  GameBoardView.swift
//  toe
//
//  Created by Sumo Akula on 1/3/22.
//

import SwiftUI

struct GameBoardView: View {
    @EnvironmentObject var game: TicTacToeGame
    
    var body: some View {
        VStack {
            ForEach(ButtonRow.allCases) { row in
                HStack {
                    ForEach(ButtonColumn.allCases) { col in
                        TicTacToeButton(row: row, col: col)
                    }
                }
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
