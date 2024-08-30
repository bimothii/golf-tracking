//
//  GameView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import SwiftUI
import FirebaseFirestore

struct GameView: View {
    @StateObject var viewModel:GameViewModel
    var game:Game
    var editGame: (_ game:Game) -> Void
    init(userId:String, game:Game, editGame: @escaping (_ game:Game) -> Void) {
        self._viewModel = StateObject(wrappedValue: GameViewModel())
        self.game = game
        self.editGame = editGame
    }
    
    var body: some View {
            VStack {
                if game.holes.isEmpty {
                    Text("Click + in the Top Right to Add a Hole")
                } else {
                    List {
                        ForEach(game.holes.indices, id: \.self) { index in
                            HoleView(index: index + 1, hole: game.holes[index], executeAction: {
                                viewModel.holeIndex = index
                                viewModel.showEditHoleView = true
                            })
                        }
                    }
                    Text("Green in Regulation: " + String(viewModel.greenPercentage(game: game)) + "%")
                }
            }
            .navigationTitle(game.title)
            .toolbar {
                Button {
                    viewModel.showAddHole = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showAddHole) {
                AddHoleView(showAddView: $viewModel.showAddHole, game: game)
            }
            .sheet(isPresented: $viewModel.showEditHoleView) {
                EditHoleView(showEditView: $viewModel.showEditHoleView, game: game, index: viewModel.holeIndex)
            }
    }
}
func temp (game:Game) {
    print("test")
}

#Preview {

    GameView(userId: UUID().uuidString, game: Game(id: UUID().uuidString, title: "Test", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970), editGame:temp)
}
