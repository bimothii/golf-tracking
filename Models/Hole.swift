//
//  Hole.swift
//  PracticumProject
//
//  Created by Brian Kim on 8/30/24.
//

import Foundation

struct Hole: Codable, Identifiable {
    let id: String
    
    let par: Int
    let yardage: Int
    let score: Int
    
    let club: String
    let fairway: Bool
    let missTee: Bool
    
    let clubHit: String
    let gir: Bool
    let missApproach: String
    
    let upAndDown: Bool
    
    let totalPutts: Int
    let firstPuttDist: Int
    
    let penaltyStrokes: Int
    let shotsInside100: Int
}
