//
//  User.swift
//  GolfApp
//
//  Created by Brian Kim on 6/12/24.
//

import Foundation

struct User: Codable {
    let id:String
    let name:String
    let email:String
    let joined:TimeInterval
    let sortBy:String
}
