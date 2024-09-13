import SwiftUI

struct CustomStepper: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int

    var body: some View {
        HStack {
            Text("\(title): \(value)")
            Spacer()
            
            Button(action: decreaseValue) {
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 40, height: 30)
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(value <= range.lowerBound ? Color(red: 0.5, green: 0.5, blue: 0.5) : Color(uiColor: UIColor { traitCollection in
                        traitCollection.userInterfaceStyle == .dark ? .white : .black
                    }))
                    .font(.title)
                    .cornerRadius(10)
            }
            .disabled(value <= range.lowerBound) // Disable if at lower bound
            
            Button(action: increaseValue) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .frame(width: 40, height: 30)
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(value >= range.upperBound ? Color(red: 0.5, green: 0.5, blue: 0.5) : Color(uiColor: UIColor { traitCollection in
                        traitCollection.userInterfaceStyle == .dark ? .white : .black
                    }))
                    .font(.title)
                    .cornerRadius(10)
            }
            .disabled(value >= range.upperBound) // Disable if at upper bound
        }
        .frame(height: 40)
    }

    private func increaseValue() {
        if value < range.upperBound {
            value += step
        }
    }

    private func decreaseValue() {
        if value > range.lowerBound {
            value -= step
        }
    }
}

struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        @State var testValue = 0
        CustomStepper(title:"Test", value: $testValue, range: 0...10, step: 1)
            .padding()
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
    }
}
