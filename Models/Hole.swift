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
    
    let teeClub: String
    let teeShot: String
    
    let approachClub: String
    let approachShot: String
    
    let upAndDown: Bool
    
    let totalPutts: Int
    let firstPuttDist: Int
    
    let penaltyStrokes: Int
    let shotsInside100: Int
}

struct HoleConstants {
    static let par: Int = 0
    static let yardage: Int = 0
    static let score: Int = 0
    
    static let teeClub: String = "-"
    static let teeShot: String = "-"
    
    static let approachClub: String = "-"
    static let approachShot: String = "-"
    
    static let upAndDown: Bool = true
    
    static let totalPutts: Int = -1
    static let firstPuttDist: Int = 0
    
    static let penaltyStrokes: Int = -1
    static let shotsInside100: Int = -1
    
    static let teeShots:[String] = [
        "-",
        "Fairway",
        "Left",
        "Right",
    ]
    
    static let approachShots:[String] = [
        "-",
        "GIR",
        "Short Left",
        "Short Right",
        "Left",
        "Right",
        "Long Left",
        "Long Right"
    ]
    
    static let clubs:[String] = [
        "-",
        "Driver",
        "3-Wood",
        "4-Wood",
        "5-Wood",
        "7-Wood",
        "2-Hybrid",
        "3-Hybrid",
        "4-Hybrid",
        "5-Hybrid",
        "2-Iron",
        "3-Iron",
        "4-Iron",
        "5-Iron",
        "6-Iron",
        "7-Iron",
        "8-Iron",
        "9-Iron",
        "Pitching Wedge",
        "Gap/Approach Wedge",
        "Lob Wedge",
        "Sand Wedge"
    ]
}
