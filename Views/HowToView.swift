//
//  HowToView.swift
//  PracticumProject
//
//  Created by Brian Kim on 9/6/24.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack {
            Form {
                Text("Click the plus in the top right to add a game or add a hole.")
                HStack {
                    Text("It looks this this: ")
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
                Text("Swipe left on a game to edit or delete it.")
                Text("Swipe left on this text to see.")
                    .swipeActions {
                        Button ("This") {
                        }
                        .tint(Color.red)
                    }
                    .swipeActions {
                        Button ("Like") {
                        }
                    }
            }
        }
        .navigationTitle("How To Use the App")
    }
}

#Preview {
    HowToView()
}
