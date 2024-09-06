//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Brian Kim on 6/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0,
                    sortBy: data["sortBy"] as? String ?? "sortBy"                )
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func deleteUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let documentRef = db.collection("users").document(userId)

        // Perform the delete operation
        documentRef.delete { error in
            if let error = error {
                print("Error removing document: \(error.localizedDescription)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                } else {
                    print("User account successfully deleted!")
                }
            }
        } else {
            print("No user is currently signed in.")
        }
        
        logout()
    }
}
