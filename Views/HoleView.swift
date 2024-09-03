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
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text("Par: " + String(hole.par))
//                    Text("Strokes: " + String(hole.strokes))
//                    Text("Putts: " + String(hole.putts))
                }
            }
        }
    }
}
//
//#Preview {
//    HoleView(index: 1, hole: Hole(id: UUID().uuidString, par: hol, yardage: <#T##Int#>, score: <#T##Int#>, club: <#T##String#>, fairway: <#T##Bool#>, missTee: <#T##Bool#>, clubHit: <#T##String#>, gir: <#T##Bool#>, missApproach: <#T##String#>, upAndDown: <#T##Bool#>, totalPutts: <#T##Int#>, firstPuttDist: <#T##Int#>, penaltyStrokes: <#T##Int#>, shotsInside100: <#T##Int#>), executeAction: {})
//}
