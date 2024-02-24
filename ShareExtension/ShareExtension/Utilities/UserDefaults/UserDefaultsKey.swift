//
//  UserDefaultsKey.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 24.02.24.
//

enum UserDefaultsKey: String, CaseIterable {
    case token
    case isLoggedIn
    
    var value: String {
        return self.rawValue
    }
}
