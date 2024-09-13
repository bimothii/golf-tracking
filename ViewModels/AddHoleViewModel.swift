//
//  AddHoleViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AddHoleViewModel:ObservableObject {
    @Published var par: Int = HoleConstants.par
    @Published var yardage: Int = HoleConstants.yardage
    @Published var score: Int = HoleConstants.score
    
    @Published var teeClub: String = HoleConstants.teeClub
    @Published var teeShot: String = HoleConstants.teeShot
    
    @Published var approachClub: String = HoleConstants.approachClub
    @Published var approachShot: String = HoleConstants.approachShot
    
    @Published var upAndDown: Bool = HoleConstants.upAndDown
    
    @Published var totalPutts: Int = HoleConstants.totalPutts
    @Published var firstPuttDist: Int = HoleConstants.firstPuttDist
    
    @Published var penaltyStrokes: Int = HoleConstants.penaltyStrokes
    @Published var shotsInside100: Int = HoleConstants.shotsInside100
    
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes.append(Hole(id: UUID().uuidString, par: par, yardage: yardage, score: score, teeClub: teeClub, teeShot: teeShot, approachClub: approachClub, approachShot: approachShot, upAndDown: upAndDown, totalPutts: totalPutts, firstPuttDist: firstPuttDist, penaltyStrokes: penaltyStrokes, shotsInside100: shotsInside100))
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
