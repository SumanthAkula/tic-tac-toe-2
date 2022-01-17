//
//  TicTacToeGame.swift
//  toe
//
//  Created by Sumo Akula on 12/28/21.
//

import Foundation
import SwiftUI

final class TicTacToeGame: ObservableObject {
    private static let BUTTON_STATE_ARRAY_BLANK: [[ButtonState]] = Array(repeating: Array(repeating: ButtonState(player: nil, color: nil), count: ButtonColumn.allCases.count), count: ButtonRow.allCases.count)
    
    @Published private(set) var turn: Turn = .X
    private var numTurns: Int = 0   // max number of turns is 9
    @Published private(set) var buttonStates: [[ButtonState]] = TicTacToeGame.BUTTON_STATE_ARRAY_BLANK
    private(set) var winner: Turn? = nil
    @Published var showingGameOverAlert: Bool = false
    private(set) var gameOver: Bool = false
    
    init() {
        self.resetGame()
    }
    
    // MARK: - game reset logic
    public func resetGame() {
        self.buttonStates = TicTacToeGame.BUTTON_STATE_ARRAY_BLANK
        self.turn = .X
        self.numTurns = 0
        self.winner = nil
        self.gameOver = false
    }
    
    //MARK: - handling button taps
    public func buttonTapped(row: ButtonRow, col: ButtonColumn) {
        guard (self.buttonStates[row.rawValue][col.rawValue].player == nil && !gameOver) else {
            return
        }
        
        self.buttonStates[row.rawValue][col.rawValue].player = self.turn
        self.turn.toggle()
        self.numTurns += 1
        
        if let winner = self.checkForWinner() {
            self.winner = winner
            self.gameOver = true
        } else if (self.numTurns >= 9) {
            for row in 0..<self.buttonStates.count {
                for col in 0..<self.buttonStates[row].count {
                    self.buttonStates[row][col].color = Color.red
                }
            }
            self.gameOver = true
        }
        
        if (gameOver) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            showingGameOverAlert.toggle()
        } else {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        }
    }
    
    // MARK: - checking for a winner
    private func checkForWinner() -> Turn? {
        // check each row
        for (rowIndex, row) in self.buttonStates.enumerated() {
            let x = row.compactMap { $0.player }.filter { $0 == .X }.count
            let o = row.compactMap { $0.player }.filter { $0 == .O }.count
            if let winner = self.checkPlayerSpotCounts(x: x, o: o) {
                for (col, _) in self.buttonStates.enumerated() {
                    self.buttonStates[rowIndex][col].color = Color.green
                }
                return winner
            }
        }
        
        // check each column
        for col in ButtonColumn.allCases {
            let x = self.buttonStates.compactMap { $0[col.rawValue] }.compactMap { $0.player }.filter { $0 == .X }.count
            let o = self.buttonStates.compactMap { $0[col.rawValue] }.compactMap { $0.player }.filter { $0 == .O }.count
            
            if let winner = self.checkPlayerSpotCounts(x: x, o: o) {
                for (row, _) in self.buttonStates.enumerated() {
                    self.buttonStates[row][col.rawValue].color = Color.green
                }
                return winner
            }
        }
        
        // check each diagonal
        let negative = self.buttonStates.enumerated().map { $1[$0] }.compactMap { $0.player }
        let positive = self.buttonStates.enumerated().map { $1.reversed()[$0] }.compactMap { $0.player }
        if let result = self.checkPlayerSpotCounts(x: negative.filter { $0 == .X }.count, o: negative.filter { $0 == .O }.count) {  // checking negative diagonal
            for row in ButtonRow.allCases {
                self.buttonStates[row.rawValue][row.rawValue].color = Color.green
            }
            return result
        } else if let result = self.checkPlayerSpotCounts(x: positive.filter { $0 == .X }.count, o: positive.filter { $0 == .O }.count) {   // checking positive diagonal
            for row in ButtonRow.allCases {
                self.buttonStates[row.rawValue][(ButtonColumn.allCases.count - 1) - row.rawValue].color = Color.green
            }
            return result
        }
        
        return nil  // if no winner, return nil
    }
    
    private func checkPlayerSpotCounts(x: Int, o: Int) -> Turn? {
        if (x == 3 && o != 3) {
            return .X
        } else if (o == 3 && x != 3) {
            return .O
        } else {
            return nil
        }
    }
}
