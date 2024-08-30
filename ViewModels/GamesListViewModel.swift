//
//  GamesListViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/14/24.
//

import Foundation
import FirebaseFirestore

class GamesListViewModel: ObservableObject {
    @Published var games:[Game] = []
    @Published var sortBy:String = "Name"
    @Published var showingNewGameView: Bool = false
    @Published var showDeleteConfirmation = false
    @Published var showEditGame = false
    @Published var selectedGame:Game = Game(id: "asdf", title: "asdf", createdDate: 0, gameDate: Date().timeIntervalSince1970)
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete() {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("games")
            .document(selectedGame.id)
            .delete()
    }
    
    func edit(newTitle:String) {
        let gameCopy = Game(id: selectedGame.id, title: newTitle, createdDate: selectedGame.createdDate, gameDate: Date().timeIntervalSince1970, holes: selectedGame.holes)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
    
    func edit(gameCopy:Game) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("games")
            .document(gameCopy.id)
            .setData(gameCopy.asDictionary())
    }
    
    func setSortBy(newSortBy:String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .updateData([
                "sortBy": newSortBy
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
    }
    
    func sortGames() {
        if sortBy == "Name" {
            games = games.sorted(by: { $0.title < $1.title })
        }
        else if sortBy == "Date" {
            games = games.sorted(by: { $0.gameDate < $1.gameDate })
        }
        else if sortBy == "Score" {

            games = games.sorted(by: { (game1: Game, game2: Game) -> Bool in
                if game1.score() == game2.score() {
                    return game1.title < game2.title
                } else {
                    return game1.score() < game2.score()
                }
            })        }
        else {
            games = games.sorted(by: { $0.title < $1.title })
        }
        for game in games {
            print(game.title, game.gameDate)
        }
    }
    
    func fetchGames() {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("games")
            .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents.")
                        return
                    }

                    self.games = documents.compactMap { queryDocumentSnapshot -> Game? in
                        return try? queryDocumentSnapshot.data(as: Game.self)
                    }
                
                    self.sortGames()
                }
        db.collection("users")
            .document(userId)
            .addSnapshotListener { (documentSnapshot, error) in
                guard let document = documentSnapshot else {
                    print("No documents.")
                    return
                }
                
                if let value = document.data()?["sortBy"] as? String {
                    self.sortBy = value
                }
                else {
                    self.sortBy = "Name"
                }
                self.sortGames()
            }
    }
}
