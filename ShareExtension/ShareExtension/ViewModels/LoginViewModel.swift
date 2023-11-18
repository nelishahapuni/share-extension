//
//  LoginViewModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import Foundation

class LoginViewModel: ObservableObject {

    private let token = UUID()
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
        // TODO: - Validate parameters before calling completion
        // TODO: - Save login info in user defaults
        completion(true)
    }
}
