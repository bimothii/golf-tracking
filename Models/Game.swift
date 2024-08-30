//
//  Game.swift
//  GolfApp
//
//  Created by Brian Kim on 6/14/24.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: String
    let title: String
    let createdDate: TimeInterval
    let gameDate: TimeInterval
    var holes: [Hole] = []
    
    func score() -> Int {
        var total = 0
        for hole in holes {
            total += max(hole.par - hole.strokes - hole.putts, 0)
        }
        return total
    }
}
