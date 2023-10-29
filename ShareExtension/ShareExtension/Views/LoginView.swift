//
//  LoginView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct LoginView: View {


    @State private var isLoginPressed: Bool = false

    @ObservedObject private var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                usernameInput
                Divider()
                passwordInput
                Divider()
                Spacer()
                loginButton
            }
            .padding()
            .padding(.horizontal)
            .navigationDestination(
                isPresented: $isLoginPressed) {
                    HomeView()
                }
        }
    }

    private var usernameInput: some View {
        TextField(
            "Username",
            text: $viewModel.username
        )
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .padding(.top)
    }

    private var passwordInput: some View {
        SecureField(
            "Password",
            text: $viewModel.password
        )
        .padding(.top)
    }

    private var loginButton: some View {
        Button {
            viewModel.validate { isValid in
                if isValid {
                    isLoginPressed = true
                }
            }
        } label: {
            Text("Login")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.white)
                .background(Color.yellow)
                .cornerRadius(10)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
}
