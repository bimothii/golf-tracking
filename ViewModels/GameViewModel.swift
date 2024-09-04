//
//  GameViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class GameViewModel: ObservableObject {
    @Published var showAddHole = false
    @Published var showEditHoleView = false
    @Published var holeIndex = -1
    
    func deleteHole(game:Game, index:Int) {
        var gameCopy = game
        gameCopy.holes.remove(at: index)
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
