//
//  HoleView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/17/24.
//

import SwiftUI

struct HoleView: View {
    let index:Int
    let hole:Hole
    let executeAction: () -> Void
    var body: some View {
        Button {
            executeAction()
        } label: {
            HStack {
                VStack {
                    Text("Hole " + String(index))
                        .padding(.bottom, 5)
                    
                    if hole.par - hole.strokes >= 2 {
                        Text("✅")
                    }
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text("Par: " + String(hole.par))
                    Text("Strokes: " + String(hole.strokes))
                    Text("Putts: " + String(hole.putts))
                }
            }
        }
    }
}

#Preview {
    HoleView(index: 1, hole: Hole(id: UUID().uuidString, par: 4, strokes: 1, putts: 1), executeAction: {})
}
