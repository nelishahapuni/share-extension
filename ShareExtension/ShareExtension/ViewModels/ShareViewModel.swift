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

    func saveDataToDocuments(_ data: Data?, imageFileName: String = Strings.sharedImageName) {
        guard let imageFileURL = getDocumentsDirectory()?.appendingPathComponent(imageFileName) else { return }

        do {
            try data?.write(to: imageFileURL)
            uploadStatus.success = true
        } catch {
            uploadStatus.error = error
        }
    }
}

private extension ShareViewModel {

    private func getDocumentsDirectory() -> URL? {
        let paths = Strings.directoryPath
        return URL(fileURLWithPath: paths)
    }
}
