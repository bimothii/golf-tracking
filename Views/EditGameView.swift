//
//  EditGameView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/19/24.
//

import SwiftUI

struct EditGameView: View {
    
    @StateObject var viewModel:EditGameViewModel
    @Binding var showEditGame:Bool
    
    init(game:Game, showEditGame:Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: EditGameViewModel(game: game))
        self._showEditGame = showEditGame
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Game Name", text: $viewModel.title)
                DatePicker("Game Date", selection: $viewModel.gameDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                HStack {
                    Spacer()
                    CustomButton(title: "Save Game", color: .purple) {
                        viewModel.saveGame()
                        showEditGame = false
                    }
                    Spacer()
                }
            }
            Button {
                showEditGame = false
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    EditGameView(game: Game(id: UUID().uuidString, title: "Test Game", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970), showEditGame: Binding(get: {return true}, set: {_ in}))
}
