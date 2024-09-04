//
//  ContentView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                GamesListView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Games", systemImage: "figure.golf")
                    }
                SettingsView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
