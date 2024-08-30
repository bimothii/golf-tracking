//
//  LoginViewModel.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var errorMessage:String = ""
    
    init() {}
    
    func login() {
        errorMessage = ""
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        let trimmedPassword = password.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedEmail.isEmpty && !trimmedPassword.isEmpty else {
            errorMessage = "Please fill out all fields."
            return
        }
        
        guard isValidEmail(trimmedEmail) else {
            errorMessage = "Please enter a valid email address."
            return
        }
        
        Auth.auth().signIn(withEmail: trimmedEmail, password: trimmedPassword) { [weak self] authResult, error in
            guard self != nil else {
                self?.errorMessage = "Incorrect password."
                return
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
