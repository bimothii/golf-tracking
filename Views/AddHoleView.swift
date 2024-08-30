//
//  NewHoleView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import SwiftUI

struct AddHoleView: View {
    @StateObject var viewModel:AddHoleViewModel
    @Binding var showAddView:Bool
    let game:Game
    
    init (showAddView:Binding<Bool>, game:Game) {
        self._viewModel = StateObject(wrappedValue: AddHoleViewModel())
        self.game = game
        self._showAddView = showAddView
    }
    var body: some View {
        VStack {
            Form {
                Stepper("Par: \(viewModel.par)", value: $viewModel.par, in: 3...5)
                Stepper("Strokes: \(viewModel.strokes)", value: $viewModel.strokes, in: 1...100)
                Stepper("Putts: \(viewModel.putts)", value: $viewModel.putts, in: 1...100)
                HStack {
                    Spacer()
                    CustomButton(title: "Save Hole", color: .purple) {
                        viewModel.saveHole(game:game)
                        showAddView = false
                    }
                    Spacer()
                }
            }
            Button {
                showAddView = false
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    AddHoleView(showAddView: Binding(get: {return true}, set: {_ in}), game:Game(id: UUID().uuidString, title: "Game 1", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970))
}
