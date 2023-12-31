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
}

// MARK: - Private Views

private extension LoginView {

    var usernameInput: some View {
        TextField(
            LoginLabel.username,
            text: $viewModel.username
        )
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .padding(.top)
    }

    var passwordInput: some View {
        SecureField(
            LoginLabel.password,
            text: $viewModel.password
        )
        .padding(.top)
    }

    var loginButton: some View {
        Button {
            viewModel.validate { isValid in
                if isValid {
                    isLoginPressed = true
                }
            }
        } label: {
            Text(LoginLabel.login)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: LoginButton.maxHeight)
                .foregroundColor(Color.white)
                .background(Color.yellow)
                .cornerRadius(LoginButton.cornerRadius)
        }
    }
}

// MARK: - Constants

private extension LoginView {

    enum LoginButton {
        static let maxHeight: CGFloat = 60
        static let cornerRadius: CGFloat = 10
    }

    enum LoginLabel {
        static let username = "Username"
        static let password = "Password"
        static let login = "Login"
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
}
