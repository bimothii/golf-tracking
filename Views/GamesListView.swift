//
//  ContentView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import SwiftUI
import FirebaseFirestore
//import FirebaseFirestoreSwift

struct GamesListView: View {
    @StateObject var viewModel: GamesListViewModel
    var userId:String
    var options = ["Name", "Date", "Score"]
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: GamesListViewModel(userId:userId))
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if (viewModel.games.count == 0) {
                    Text("Click the plus in the top right to add a game")
                        .padding(.top, 30.0)
                    Spacer()
                } else {
                    List(viewModel.games) { game in
                        NavigationLink(destination: GameView(userId:userId, game: game, editGame:viewModel.edit)) {
                            HStack{
                                Text(game.title)
                                Spacer()
                                Text(game.getDate())
                            }
                        }
                        .swipeActions {
                            Button("Edit") {
                                viewModel.showEditGame = true
                                viewModel.selectedGame = game
                            }
                        }
                        .swipeActions {
                            Button ("Delete") {
                                viewModel.showDeleteConfirmation = true
                                viewModel.selectedGame = game
                            }
                            .tint(Color.red)
                        }
                    }
                }
            }
            .navigationTitle("Games")
            .toolbar {
                Button {
                    viewModel.showingNewGameView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewGameView, content: {
                NewGameView(showingNewGameView: $viewModel.showingNewGameView)
            })
            .sheet(isPresented: $viewModel.showEditGame, content: {
                EditGameView(game: viewModel.selectedGame, showEditGame: $viewModel.showEditGame)
            })

        }
        .alert(isPresented: $viewModel.showDeleteConfirmation) {
            Alert(
                title: Text("Delete Game"),
                message: Text("Are you sure you want to delete this game?"),
                primaryButton: .destructive(Text("Delete Game")) {
                    viewModel.delete()
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear() {
            viewModel.fetchGames()
        }
        
    }
}

#Preview {
    GamesListView(userId: "QNTdtlmrQBVD23HEag7gKAannVi2")
}
