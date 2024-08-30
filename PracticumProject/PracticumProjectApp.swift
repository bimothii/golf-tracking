//
//  PracticumProjectApp.swift
//  PracticumProject
//
//  Created by Brian Kim on 8/21/24.
//

import SwiftUI
import Firebase

@main
struct PracticumProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
