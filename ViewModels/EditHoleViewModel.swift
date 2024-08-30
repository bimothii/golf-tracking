//
//  NewHoleViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class EditHoleViewModel:ObservableObject {
    @Published var index:Int
    @Published var par:Int
    @Published var strokes:Int
    @Published var putts:Int
    
    init (index:Int, hole:Hole) {
        self.index = index
        par = hole.par
        strokes = hole.strokes
        putts = hole.putts
    }
    
    func saveHole(game:Game) {
        var gameCopy = game
        gameCopy.holes[index] = Hole(id: UUID().uuidString, par: par, strokes: strokes, putts: putts)
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
}
