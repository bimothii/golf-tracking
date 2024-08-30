//
//  NewGameViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewGameViewModel: ObservableObject {
    @Published var title = ""
    @Published var gameDate = Date()
    
    init() {}
    
    func save() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let newId = UUID().uuidString
        let newGame = Game(id: newId, title: title, createdDate: Date().timeIntervalSince1970, gameDate: gameDate.timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(newId)
            .setData(newGame.asDictionary())
    }
}
