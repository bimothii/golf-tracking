//
//  SetttingsView.swift
//  PracticumProject
//
//  Created by Brian Kim on 9/5/24.
//


import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel:SettingsViewModel
    var userId:String
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: SettingsViewModel(userId:userId))
        self.userId = userId
    }
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Profile", destination: ProfileView())
                Picker("Sort Games By", selection: $viewModel.sortBy) {
                    Text("Name").tag("Name")
                    Text("Date").tag("Date")
                }
                .onChange(of: viewModel.sortBy) {
                    viewModel.setSortBy(newSortBy: viewModel.sortBy)
                }
                .pickerStyle(MenuPickerStyle())
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            viewModel.fetchSortBy()
        }
    }
}

#Preview {
    SettingsView(userId: UUID().uuidString)
}
