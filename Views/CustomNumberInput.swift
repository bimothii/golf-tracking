//
//  CustomNumberInput.swift
//  PracticumProject
//
//  Created by Brian Kim on 9/27/24.
//

import SwiftUI

import SwiftUI

struct CustomNumberInput: View {
    var title: String
    @Binding var value: Int
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle()) // Ensures the entire area is tappable
                .onTapGesture {
                    isFocused = false
                }

            HStack {
                Text(title)
                Spacer()
                TextField("", value: $value, formatter: NumberFormatter())
                    .frame(width: 95, height: 20)
                    .focused($isFocused)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .frame(height: 40)
    }
}
