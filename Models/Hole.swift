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
    let strokes: Int
    let putts: Int
}
