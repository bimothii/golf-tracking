//
//  NewHoleViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AddHoleViewModel:ObservableObject {
    @Published var par:Int = 4
    @Published var strokes:Int = 3
    @Published var putts:Int = 2
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes.append(Hole(id: UUID().uuidString, par: par, strokes: strokes, putts: putts))
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
