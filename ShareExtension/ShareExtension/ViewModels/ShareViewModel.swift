//
//  ShareViewModel.swift
//  CustomShareExtension
//
//  Created by Neli Shahapuni on 5.02.24.
//

import Foundation
import SwiftUI

class ShareViewModel: ObservableObject {
    @Published var uploadStatus = UploadStatus(success: false)
    @Published var image: UIImage?

    func saveDataToDocuments(_ data: Data?) {
        let imageName = String.generateRandomImageName()
        let imageFileURL = URL.documentsDirectory.appendingPathComponent(imageName)

        do {
            try data?.write(to: imageFileURL)
            uploadStatus.success = true
        } catch {
            uploadStatus.error = error
        }
    }
}
