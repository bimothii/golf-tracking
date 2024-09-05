//
//  SettingsViewModel.swift
//  PracticumProject
//
//  Created by Brian Kim on 9/5/24.
//

import Foundation
import FirebaseFirestore

class SettingsViewModel:ObservableObject {
    private let userId: String
    @Published var sortBy:String = "Name (A-Z)"
    
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
    
    func fetchSortBy() {
        let db = Firestore.firestore()
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
            }
    }
    
    init(userId: String) {
        self.userId = userId
    }
}
