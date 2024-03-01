//
//  LoginViewModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String
    @Published var password: String

    public init(
        loginRequest: LoginModel
    ) {
        self.username = loginRequest.username
        self.password = loginRequest.password
    }
}

// MARK: - Public Methods

extension LoginViewModel {

    /// Validate whether the user credentials - username & password - are valid. Then generate an access token (UUID) and pass success (true) or error (false) through the completion closure.
    /// - Parameter completion: an escaping closure that returns true or false.
    func validate(completion: @escaping (Bool) -> Void) {
        if !username.isEmpty,
           !password.isEmpty {
            let token: String? = UserDefaultManager.shared.get(for: .token)

            if token == nil {
                setUserDefaults(username, UUID().uuidString)
            }
            completion(true)
        }
    }
}

// MARK: - Private Method

private extension LoginViewModel {
    func setUserDefaults(_ username: String, _ token: String) {
        UserDefaultManager.shared.set(username, for: .username)
        UserDefaultManager.shared.set(token, for: .token)
    }
}
