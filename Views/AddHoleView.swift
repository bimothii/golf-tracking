import SwiftUI

struct AddHoleView: View {
    @StateObject var viewModel: AddHoleViewModel
    @Binding var showAddView: Bool
    @FocusState private var isYardageFieldFocused: Bool
    @FocusState private var isFirstPuttDistFocused: Bool
    let game: Game
    
    init(showAddView: Binding<Bool>, game: Game) {
        self._viewModel = StateObject(wrappedValue: AddHoleViewModel())
        self.game = game
        self._showAddView = showAddView
    }
    
    var body: some View {
        // Use a ZStack to layer the background color
        ZStack {
            // Wrap everything in a ScrollView for better accessibility
            ScrollView {
                VStack(spacing: 20) {
                    Text("Add New Hole")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding([.top, .trailing], 7.5)

                    // Par Selection Buttons
                    HStack(spacing: 20) {
                        ForEach(3...5, id: \.self) { par in
                            Button(action: {
                                if viewModel.par == par {
                                    viewModel.par = HoleConstants.par
                                } else {
                                    viewModel.par = par
                                }
                            }) {
                                Text("Par \(par)")
                                    .padding()
                                    .background(viewModel.par == par ? Color.purple : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding()

                    CustomNumberInput(title: "Yardage", value: $viewModel.yardage, isFocused: $isYardageFieldFocused)
                    
                    // Score Stepper
                    CustomStepper(title: "Score", value: $viewModel.score, range: 0...100, step: 1)
                    
                    // Additional Sections Based on Conditions
                    if viewModel.par != 3 {
                        HStack {
                            Text("Tee Club")
                            Spacer()
                            Picker("Tee Club", selection: $viewModel.teeClub) {
                                ForEach(HoleConstants.clubs, id: \.self) { club in
                                    Text(club).tag(club)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        CustomSelect(title: "Tee Shot", value: $viewModel.teeShot, options: HoleConstants.teeShots)
                    }
                        
                    CustomSelect(title: "Approach Club", value: $viewModel.approachClub, options: HoleConstants.clubs)

                    ApproachShot(value: $viewModel.approachShot)
                    
                    // Short Game Section if Approach Shot is GIR
                    if viewModel.approachShot == "GIR" {
                        Toggle("Up and Down", isOn: $viewModel.upAndDown)
                    }
                    
                    CustomStepper(title: "Total Putts", value: $viewModel.totalPutts, range: -1...100, step: 1)
                    
                    CustomNumberInput(title: "First Putt Distance", value: $viewModel.firstPuttDist, isFocused: $isFirstPuttDistFocused)
                    
                    CustomStepper(title: "Penalty Strokes", value: $viewModel.penaltyStrokes, range: -1...100, step: 1)
                    CustomStepper(title: "Shots Inside 100 Yards", value: $viewModel.shotsInside100, range: -1...100, step: 1)
                    
                    // Save and Cancel Buttons
                    HStack {
                        Spacer()
                        CustomButton(title: "Add Hole", color: .purple) {
                            viewModel.saveHole(game: game)
                            showAddView = false
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            showAddView = false
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
                .padding(20) // Add padding around the VStack
                .background(Color(uiColor: UIColor { traitCollection in
                    traitCollection.userInterfaceStyle == .dark ? UIColor(white:0.1, alpha: 1) : UIColor(white: 0.9, alpha: 1)
                }))
            }
            .onTapGesture {
                // Resign the focus when tapping outside the TextField
                isYardageFieldFocused = false
                isFirstPuttDistFocused = false
            }
            .padding(10)
            .cornerRadius(50)
            
        }
    }
}

#Preview {
    AddHoleView(showAddView: Binding(get: { true }, set: { _ in }), game: Game(id: UUID().uuidString, title: "Game 1", createdDate: Date().timeIntervalSince1970, gameDate: Date().timeIntervalSince1970))
}
