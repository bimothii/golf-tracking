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
    
    @Published var club: String = HoleConstants.club
    @Published var fairway: Bool = HoleConstants.fairway
    @Published var missTee: String = HoleConstants.missTee
    
    @Published var clubHit: String = HoleConstants.clubHit
    @Published var gir: Bool = HoleConstants.gir
    @Published var missApproach: String = HoleConstants.missApproach
    
    @Published var upAndDown: Bool = HoleConstants.upAndDown
    
    @Published var totalPutts: Int = HoleConstants.totalPutts
    @Published var firstPuttDist: Int = HoleConstants.firstPuttDist
    
    @Published var penaltyStrokes: Int = HoleConstants.penaltyStrokes
    @Published var shotsInside100: Int = HoleConstants.shotsInside100
    
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes.append(Hole(id: UUID().uuidString, par: par, yardage: yardage, score: score, club: club, fairway: fairway, missTee: missTee, clubHit: clubHit, gir: gir, missApproach: missApproach, upAndDown: upAndDown, totalPutts: totalPutts, firstPuttDist: firstPuttDist, penaltyStrokes: penaltyStrokes, shotsInside100: shotsInside100))
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
