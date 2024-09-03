//
//  EditGameViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class EditGameViewModel:ObservableObject {
    
    let game:Game
    var title:String
    var gameDate = Date()
    
    init(game: Game) {
        self.game = game
        self.title = game.title
        self.gameDate = Date(timeIntervalSince1970: game.gameDate)
    }
    
    func saveGame() {
        let gameCopy = Game(id: game.id, title: title, createdDate: game.createdDate, gameDate: gameDate.timeIntervalSince1970)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
