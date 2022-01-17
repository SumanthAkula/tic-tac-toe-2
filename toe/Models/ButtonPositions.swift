//
//  ButtonPositions.swift
//  toe
//
//  Created by Sumo Akula on 12/22/21.
//

import Foundation

enum ButtonRow: Int, CaseIterable, Identifiable {
    var id: Self { self }
    
    case a = 0
    case b = 1
    case c = 2
}

enum ButtonColumn: Int, CaseIterable, Identifiable {
    var id: Self { self }
    
    case a = 0
    case b = 1
    case c = 2
}
