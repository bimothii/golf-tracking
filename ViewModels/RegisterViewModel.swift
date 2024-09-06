import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var errorMessage:String = ""
    
    init() {}
    
    func register() {
        errorMessage = ""
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        let trimmedPassword = password.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedEmail.isEmpty && !trimmedPassword.isEmpty && !name.isEmpty else {
            errorMessage = "Please fill out all fields."
            return
        }
        
        guard isValidEmail(trimmedEmail) else {
            errorMessage = "Please enter a valid email address."
            return
        }
        
        guard trimmedPassword.count > 6 else {
            errorMessage = "Please enter a longer password."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                self?.errorMessage = String(error?.localizedDescription ?? "Something went wrong.")
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970, sortBy: "Name (A-Z)")
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
