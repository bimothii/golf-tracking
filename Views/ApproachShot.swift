import SwiftUI

// Custom Shape for Pie Slice
struct PieSliceShape: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = min(rect.width, rect.height) / 6

        // Start drawing from the first point on the outer arc
        path.move(to: CGPoint(
            x: center.x + cos(CGFloat(startAngle.radians)) * innerRadius,
            y: center.y + sin(CGFloat(startAngle.radians)) * innerRadius
        ))

        // Draw the outer arc
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )

        // Draw the line connecting to the inner arc
        path.addLine(to: CGPoint(
            x: center.x + cos(CGFloat(endAngle.radians)) * innerRadius,
            y: center.y + sin(CGFloat(endAngle.radians)) * innerRadius
        ))

        // Draw the inner arc (in reverse to create the hole)
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )

        path.closeSubpath()
        return path
    }
}


struct ApproachShot: View {
    @Binding var value: String
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            ZStack {
                // LL Slice
                PieSliceButton(label: "L", color: value == "Left" ? .red : .gray, startAngle: 150, endAngle: 210, size: size) {
                    if value != "Left" {
                        value = "Left"
                    }
                    else {
                        value = "-"
                    }
                }

                // LR Slice
                PieSliceButton(label: "LL", color: value == "Long Left" ? .orange : .gray, startAngle: 210, endAngle: 270, size: size) {
                    if value != "Long Left" {
                        value = "Long Left"
                    }
                    else {
                        value = "-"
                    }
                }

                // R Slice
                PieSliceButton(label: "LR", color: value == "Long Right" ? .purple : .gray, startAngle: 270, endAngle: 330, size: size) {
                    if value != "Long Right" {
                        value = "Long Right"
                    }
                    else {
                        value = "-"
                    }
                }

                // SR Slice
                PieSliceButton(label: "R", color: value == "Right" ? .yellow : .gray, startAngle: 330, endAngle: 30, size: size) {
                    if value != "Right" {
                        value = "Right"
                    }
                    else {
                        value = "-"
                    }
                }

                // SL Slice
                PieSliceButton(label: "SR", color: value == "Short Right" ? .pink : .gray, startAngle: 30, endAngle: 90, size: size) {
                    if value != "Short Right" {
                        value = "Short Right"
                    }
                    else {
                        value = "-"
                    }
                }

                // L Slice
                PieSliceButton(label: "SL", color: value == "Short Left" ? .blue : .gray, startAngle: 90, endAngle: 150, size: size) {
                    if value != "Short Left" {
                        value = "Short Left"
                    }
                    else {
                        value = "-"
                    }
                }

                // GIR Button
                Button(action: {
                    if value != "GIR" {
                        value = "GIR"
                    }
                    else {
                        value = "-"
                    }
                }) {
                    Text("GIR")
                        .frame(width: size / 3, height: size / 3)
                        .background(value == "GIR" ? .green : .gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .font(.system(size: 24))
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        .frame(width: 250, height: 250) // Ensure it has a defined size
    }
}



// PieSliceButton Component
struct PieSliceButton: View {
    var label: String
    var color: Color
    var startAngle: Double
    var endAngle: Double
    var size: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            PieSliceShape(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle))
                .fill(color)
                .stroke(Color.black, lineWidth: 2)
                .overlay(
                    PieSliceShape(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle))
                        .stroke(Color.black, lineWidth: 2) // Outline for pie slice
                )
                .overlay(
                    Text(label)
                        .foregroundColor(.white)
                        .position(calculateTextPosition(size: size, startAngle: startAngle, endAngle: endAngle))
                        .font(.system(size: 24))
                )
        }
        .frame(width: size, height: size)
        .contentShape(PieSliceShape(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle)))
    }
    
    // Function to calculate text position based on angle
    private func calculateTextPosition(size: CGFloat, startAngle: Double, endAngle: Double) -> CGPoint {
        // Normalize angles to find the average correctly
        let normalizedStartAngle = startAngle >= 0 ? startAngle : 360 + startAngle
        let normalizedEndAngle = endAngle >= 0 ? endAngle : 360 + endAngle
        
        let averageAngle: Double
        if normalizedEndAngle > normalizedStartAngle {
            averageAngle = (normalizedStartAngle + normalizedEndAngle) / 2
        } else {
            averageAngle = (normalizedStartAngle + normalizedEndAngle + 360) / 2
        }
        
        // Use the average angle to calculate position
        let radius = size / 3 // Adjust this radius to position text better
        let x = size / 2 + radius * cos(averageAngle * .pi / 180) // Convert to radians
        let y = size / 2 + radius * sin(averageAngle * .pi / 180) // Convert to radians
        
        return CGPoint(x: x, y: y)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApproachShot(value: Binding(get: {"-"}, set: {_ in}))
    }
}
