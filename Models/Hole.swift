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
    let missTee: String
    
    let clubHit: String
    let gir: Bool
    let missApproach: String
    
    let upAndDown: Bool
    
    let totalPutts: Int
    let firstPuttDist: Int
    
    let penaltyStrokes: Int
    let shotsInside100: Int
}

struct HoleConstants {
    static let par: Int = 4
    static let yardage: Int = 400
    static let score: Int = 1
    
    static let club: String = "Driver"
    static let fairway: Bool = true
    static let missTee: String = "-"
    
    static let clubHit: String = "Iron"
    static let gir: Bool = false
    static let missApproach: String = "Short Left"
    
    static let upAndDown: Bool = true
    
    static let totalPutts: Int = 2
    static let firstPuttDist: Int = 15
    
    static let penaltyStrokes: Int = 0
    static let shotsInside100: Int = 1
}
