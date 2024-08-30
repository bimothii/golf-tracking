//
//  RegisterView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Create an Account")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                TextField("Full Name", text: $viewModel.name)
                    .padding(/*@START_MENU_TOKEN@*/.all, 25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350.0, height: 75.0)
                    .autocapitalization(.none)
                    .background(Color("TextInputBG"))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                    .disableAutocorrection(true)
                TextField("Email", text: $viewModel.email)
                    .padding(/*@START_MENU_TOKEN@*/.all, 25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350.0, height: 75.0)
                    .autocapitalization(.none)
                    .background(Color("TextInputBG"))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                    .disableAutocorrection(true)
                    .padding(.top, 10.0)
                SecureField("Password", text: $viewModel.password)
                    .padding(/*@START_MENU_TOKEN@*/.all, 25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350.0, height: 75.0)
                    .autocapitalization(.none)
                    .background(Color("TextInputBG"))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                    .disableAutocorrection(true)
                    .padding(.top, 10.0)
                Spacer()
                Spacer()
                Spacer()
                CustomButton(title: "Register", color: .purple) {
                    viewModel.register()
                }
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                Spacer()
                Spacer()
                Spacer()
            }.ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    RegisterView()
}
