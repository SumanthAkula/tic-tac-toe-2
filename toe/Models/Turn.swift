//
//  Turn.swift
//  toe
//
//  Created by Sumo Akula on 12/31/21.
//

enum Turn: String {
    case X = "X"
    case O = "O"
    
    mutating func toggle() {
        switch (self) {
            case .O:
                self = .X
                break
            case .X:
                self = .O
                break
            }
    }
}
