//
//  String+Extensions.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 26.02.24.
//

import Foundation

extension String {
    static func generateRandomImageName(_ name: String = "myImage") -> String {
        let randomNumber = Int.random(in: 1...10000)
        let fileExt = ".jpg"

        return "\(name)\(randomNumber)\(fileExt)"
    }
}
