//
//  NewHoleView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import SwiftUI

struct EditHoleView: View {
    @StateObject var viewModel:EditHoleViewModel
    @Binding var showEditView:Bool
    let game:Game
    
    init (showEditView:Binding<Bool>, game:Game, index:Int) {
        self._viewModel = StateObject(wrappedValue: EditHoleViewModel(index: index, hole: game.holes[index]))
        self.game = game
        self._showEditView = showEditView
    }
    var body: some View {
        Text("Hi")
        VStack {
            Form {
                Stepper("Par: \(viewModel.par)", value: $viewModel.par, in: 3...5)
                Stepper("Strokes: \(viewModel.strokes)", value: $viewModel.strokes, in: 1...100)
                Stepper("Putts: \(viewModel.putts)", value: $viewModel.putts, in: 1...100)
                HStack {
                    Spacer()
                    CustomButton(title: "Save Hole", color: .purple) {
                        viewModel.saveHole(game:game)
                        showEditView = false
                    }
                    Spacer()
                }
            }
            Button {
                showEditView = false
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    EditHoleView(showEditView: Binding(get: {return true}, set: {_ in}), game:Game(id: UUID().uuidString, title: "Game 1", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970), index: 0)
}
