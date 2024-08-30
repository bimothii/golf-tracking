//
//  NewGameView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import SwiftUI

struct NewGameView: View {
    @StateObject var viewModel = NewGameViewModel()
    @Binding var showingNewGameView: Bool

    var body: some View {
        VStack {
            
            Form {
                VStack {
                    Text("Game Name")
                    TextField("Enter Game Name", text: $viewModel.title)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Game Date")
                    DatePicker("Game Date", selection: $viewModel.gameDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                HStack {
                    Spacer()
                    CustomButton(title: "Create Game", color: .purple) {
                        viewModel.save()
                        showingNewGameView = false
                    }
                    Spacer()
                }
            }
            Button {
                showingNewGameView = false
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
            }
            
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    NewGameView(showingNewGameView: Binding(get: {return true}, set: {_ in}))
}
