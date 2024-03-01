//
//  LoginView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    @State private var isLoginPressed: Bool = false

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
                    HomeView(viewModel: HomeViewModel())
                }
        }
    }
}

// MARK: - Private Views

private extension LoginView {

    var usernameInput: some View {
        TextField(
            Strings.username,
            text: $viewModel.username
        )
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .padding(.top)
    }

    var passwordInput: some View {
        SecureField(
            Strings.password,
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
            Text(Strings.login)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: Numbers.loginMaxHeight)
                .foregroundColor(Color.white)
                .background(Color.yellow)
                .cornerRadius(Numbers.loginCornerRadius)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
}
