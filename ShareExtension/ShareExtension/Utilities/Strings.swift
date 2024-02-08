//
//  Strings.swift
//  CustomShareExtension
//
//  Created by Neli Shahapuni on 7.02.24.
//

import Foundation

struct Strings {
    static let username = "Username"
    static let password = "Password"
    static let login = "Login"

    static let testUsername = "nelkin"
    static let testPassword = "mypassword"

    static let sharedImageName = "myImage_\(Int.random(in: 1...10000)).jpg"
    static let directoryPath = "/Users/neli.shahapuni/Documents/share-extension"
    static let testAsset = "rabbit"

    static let pickerText = "Choose Image"
    static let uploadText = "OK"
    static let uploadError = "There was an issue with uploading your image. Please try again."

    static let shareCaption = "Share this image."
    static let shareMessage = "Save to Project Folder"

    static let publicURL = "public.url"
    static let customShareExtension = "Custom Share Extension"
    static let bundleIdentifier = "com.scalefocus.ShareExtension"
    static let cancelError = "The action has been cancelled"
}
