//
//  UserDefaultManager.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 24.02.24.
//

import Foundation

/*
 How to use

 Setters
 UserDefaultManager.shared.set("TestUserID", for: .userID)
 UserDefaultManager.shared.set(true, for: .isLoggedIn)

 Getters
 let userID: String? = UserDefaultsManager.shared.get(for: .userID)
 let isLoggedIn: Bool? = UserDefaultsManager.shared.get(for: .isLoggedIn)

 Removes all keys.
 UserDefaultsManager.shared.purge()
 */

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let userDefaults: UserDefaults?

    private init() {
        self.userDefaults = UserDefaults.standard
    }

    func remove(for key: UserDefaultsKey) {
        self.userDefaults?.removeObject(forKey: key.value)
        self.userDefaults?.synchronize()
    }

    func set<T>(_ obj: T, for key: UserDefaultsKey) {
        self.userDefaults?.set(obj, forKey: key.value)
        self.userDefaults?.synchronize()
    }

    func get<T>(for key: UserDefaultsKey) -> T? {
        let result = self.userDefaults?.object(forKey: key.value) as? T
        return result
    }

    func removeAll() {
        let keys = UserDefaultsKey.allCases
        keys.forEach {
            UserDefaultManager.shared.remove(for: $0)
        }
    }
}
