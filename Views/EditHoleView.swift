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
    @FocusState private var isYardageFieldFocused: Bool
    let game:Game
    
    init (showEditView:Binding<Bool>, game:Game, index:Int) {
        self._viewModel = StateObject(wrappedValue: EditHoleViewModel(index: index, hole: game.holes[index]))
        self.game = game
        self._showEditView = showEditView
    }
    var body: some View {
        VStack {
            Form {
                Text("Edit Hole \(viewModel.index + 1)")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .padding([.top, .trailing], 7.5)
                Stepper("Par: \(viewModel.par)", value: $viewModel.par, in: 3...5)
                HStack {
                    Text("Yardage")
                    Spacer()
                    TextField("Enter Yardage", value: $viewModel.yardage, formatter: NumberFormatter())
                        .frame(width: /*@START_MENU_TOKEN@*/95.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .focused($isYardageFieldFocused)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Stepper("Score: \(viewModel.score)", value: $viewModel.score, in: 1...12)
                
                if (viewModel.par > 3) {
                    VStack {
                        Text("Tee Shot")
                        
                        Picker("Tee Club", selection: $viewModel.teeClub) {
                            ForEach(HoleConstants.clubs, id: \.self) { club in
                                Text(club).tag(club)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        Picker("Tee Shot", selection: $viewModel.teeShot) {
                            ForEach(HoleConstants.teeShots, id: \.self) { club in
                                Text(club).tag(club)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                VStack {
                    Text("Approach")
                    
                    Picker("Approach Club", selection: $viewModel.approachClub) {
                        ForEach(HoleConstants.clubs, id: \.self) { club in
                            Text(club).tag(club)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Approach Shot", selection: $viewModel.approachShot) {
                        ForEach(HoleConstants.approachShots, id: \.self) { club in
                            Text(club).tag(club)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if (viewModel.approachShot == "GIR") {
                    VStack {
                        Text("Short Game")
                        Toggle("Up and Down", isOn: $viewModel.upAndDown)
                    }
                }
                
                VStack {
                    Text("Putts")
                    Stepper("Total Putts: \(viewModel.totalPutts)", value: $viewModel.totalPutts, in: 0...8)
                    HStack {
                        Text("First Putt Distance")
                        Spacer()
                        TextField("Enter Putt Distance", value: $viewModel.firstPuttDist, formatter: NumberFormatter())
                            .frame(width: /*@START_MENU_TOKEN@*/95.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.top, 7.0)
                    
                }
                
                VStack {
                    Stepper("Penalty Strokes: \(viewModel.penaltyStrokes)", value: $viewModel.penaltyStrokes, in: 0...10)
                    Stepper("Shots Inside 100 Yards: \(viewModel.shotsInside100)", value: $viewModel.shotsInside100, in: 0...10)
                }

                HStack {
                    Spacer()
                    CustomButton(title: "Save Hole", color: .purple) {
                        viewModel.saveHole(game:game)
                        showEditView = false
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button {
                        showEditView = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    EditHoleView(showEditView: Binding(get: {return true}, set: {_ in}), game:Game(id: UUID().uuidString, title: "Game 1", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970), index: 0)
//}
