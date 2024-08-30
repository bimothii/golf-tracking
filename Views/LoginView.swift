//
//  ContentView.swift
//  GolfApp
//
//  Created by Brian Kim on 6/11/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Golf Tracker")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                TextField("Email", text: $viewModel.email)
                    .padding(/*@START_MENU_TOKEN@*/.all, 25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350.0, height: 75.0)
                    .autocapitalization(.none)
                    .background(Color("TextInputBG"))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                    .disableAutocorrection(true)

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
                CustomButton(title: "Login", color: .purple) {
                    viewModel.login()
                }
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                Spacer()
                
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Create Account", destination: RegisterView())
                }
                .padding(50)
            }.ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    LoginView()
}
