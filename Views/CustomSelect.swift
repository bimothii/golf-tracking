//
//  CustomSelect.swift
//  PracticumProject
//
//  Created by Brian Kim on 9/27/24.
//

import SwiftUI

struct CustomSelect: View {
    let title:String
    @Binding var value:String
    let options:[String]
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Picker(title, selection: $value) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .frame(height: 40)
    }
}

#Preview {
    CustomSelect(title: "Test", value:  Binding(get: { "1" }, set: { _ in }), options: ["1", "2", "3"])
}
