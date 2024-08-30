//
//  ContentView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State var showLogoutConfirmation = false
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.purple)
                            .frame(width: 125, height: 125)
                            .padding(.top, 100)
                            .padding()
                        Text("Name: " + user.name)
                            .padding(5)
                        Text("Email: " + user.email)
                            .padding(5)
                        Text("Date Joined: " + Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
                            .padding(5)
                        Button("Log Out") {
                            showLogoutConfirmation = true
                        }
                        .tint(.red)
                        .padding(5)
                    }
                    Spacer()
                } else {
                    Text("Loading Profile...")
                    Button("Log Out") {
                        showLogoutConfirmation = true
                    }
                    .tint(.red)
                    .padding(5)
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
        .alert(isPresented: $showLogoutConfirmation) {
            Alert(
                title: Text("Log Out"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Log Out")) {
                    viewModel.logout()
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}

#Preview {
    ProfileView()
}
