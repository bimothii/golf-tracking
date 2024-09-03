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
                    Text("Score: \(hole.score)")
                }
            }
        }
    }
}

#Preview {
    HoleView(index: 0, hole: Hole(id: UUID().uuidString, par: HoleConstants.par, yardage: HoleConstants.yardage, score: HoleConstants.score, club: HoleConstants.club, fairway: HoleConstants.fairway, missTee: HoleConstants.missTee, clubHit: HoleConstants.clubHit, gir: HoleConstants.gir, missApproach: HoleConstants.missApproach, upAndDown: HoleConstants.upAndDown, totalPutts: HoleConstants.totalPutts, firstPuttDist: HoleConstants.firstPuttDist, penaltyStrokes: HoleConstants.penaltyStrokes, shotsInside100: HoleConstants.shotsInside100), executeAction: {})
}
