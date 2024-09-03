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
        VStack {
            Form {
                Stepper("Par: \(viewModel.par)", value: $viewModel.par, in: 3...5)
                HStack {
                    Text("Yardage")
                    Spacer()
                    TextField("Enter Yardage", value: $viewModel.yardage, formatter: NumberFormatter())
                        .frame(width: /*@START_MENU_TOKEN@*/95.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                Stepper("Score: \(viewModel.score)", value: $viewModel.score, in: 1...12)
                
                VStack {
                    Text("Tee Shot")
                    HStack {
                        Text("Club")
                        Spacer()
                        TextField("Enter Club", text: $viewModel.club)
                            .frame(width: /*@START_MENU_TOKEN@*/95.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Toggle("Fairway", isOn: $viewModel.fairway)
                    Picker("Miss", selection: $viewModel.missTee) {
                        Text("-").tag("-")
                        Text("Left").tag("Left")
                        Text("Right").tag("Right")
                    }
                    .pickerStyle(MenuPickerStyle())                }

                VStack {
                    Text("Approach")
                    
                    HStack {
                        Text("Club Hit")
                        Spacer()
                        TextField("Enter Club Hit", text: $viewModel.clubHit)
                            .frame(width: /*@START_MENU_TOKEN@*/95.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Toggle("Green in Regulation", isOn: $viewModel.gir)
                    
                    Picker("Miss", selection: $viewModel.missApproach) {
                        Text("Short Left").tag("Short Left")
                        Text("Short").tag("Short")
                        Text("Short Right").tag("Short Right")
                        Text("Long Left").tag("Long Left")
                        Text("Long").tag("Long")
                        Text("Long Right").tag("Long Right")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                VStack {
                    Text("Short Game")
                    Toggle("Up and Down", isOn: $viewModel.upAndDown)
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

                }
                    

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
