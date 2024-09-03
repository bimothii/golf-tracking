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
    @Published var par: Int = 4
    @Published var yardage: Int = 300
    @Published var score: Int = 0
    
    @Published var club: String = "Driver"
    @Published var fairway: Bool = true
    @Published var missTee: Bool = true
    
    @Published var clubHit: String = "Iron"
    @Published var gir: Bool = false
    @Published var missApproach: String = "Short Left"
    
    @Published var upAndDown: Bool = true
    
    @Published var totalPutts: Int = 2
    @Published var firstPuttDist: Int = 100
    
    @Published var penaltyStrokes: Int = 0
    @Published var shotsInside100: Int = 1
    
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes.append(Hole(id: UUID().uuidString, par: par, strokes: strokes, putts: putts))
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
