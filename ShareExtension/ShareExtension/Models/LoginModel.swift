//
//  LoginModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import Foundation

struct LoginModel: Encodable {

    private(set) var username: String
    private(set) var password: String

    public init(
        username: String,
        password: String
    ) {
        self.username = username
        self.password = password
    }
}

#if DEBUG
extension LoginModel {
    static var previewData: LoginModel {
        .init(
            username: Strings.testUsername,
            password: Strings.testPassword
        )
    }
}
#endif
