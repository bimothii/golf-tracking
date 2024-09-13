//
//  EditHoleViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class EditHoleViewModel:ObservableObject {
    @Published var index:Int
    
    @Published var par: Int
    @Published var yardage: Int
    @Published var score: Int
    
    @Published var teeClub: String
    @Published var teeShot: String
    
    @Published var approachClub: String
    @Published var approachShot: String
    
    @Published var upAndDown: Bool
    
    @Published var totalPutts: Int
    @Published var firstPuttDist: Int
    
    @Published var penaltyStrokes: Int
    @Published var shotsInside100: Int
    
    init (index:Int, hole:Hole) {
        self.index = index
        
        par = hole.par
        yardage = hole.yardage
        score = hole.score
        
        teeClub = hole.teeClub
        teeShot = hole.teeShot
        
        approachClub = hole.approachClub
        approachShot = hole.approachShot
        
        upAndDown = hole.upAndDown
        
        totalPutts = hole.totalPutts
        firstPuttDist = hole.firstPuttDist
        
        penaltyStrokes = hole.penaltyStrokes
        shotsInside100 = hole.shotsInside100
    }
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes[index] = Hole(id: UUID().uuidString, par: par, yardage: yardage, score: score, teeClub: teeClub, teeShot: teeShot, approachClub: approachClub, approachShot: approachShot, upAndDown: upAndDown, totalPutts: totalPutts, firstPuttDist: firstPuttDist, penaltyStrokes: penaltyStrokes, shotsInside100: shotsInside100)
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
