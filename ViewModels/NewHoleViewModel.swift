//
//  NewHoleViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NewHoleViewModel:ObservableObject {
    @Published var par:Int = 4
    @Published var strokes:Int = 1
    @Published var putts:Int = 1
    
    init() {}
    
    func addHole(game:Game) {
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
